import Foundation
import AVFoundation

class CameraManager: NSObject {
    
    private let captureSession = AVCaptureSession()
    private var deviceInput: AVCaptureDeviceInput?  // Make deviceInput optional
    private var videoOutput: AVCaptureVideoDataOutput?
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    private let sessionQueue = DispatchQueue(label: "video.preview.session")
    
    //MARK: Camera authentication request
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            var isAuthorized = status == .authorized
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            return isAuthorized
        }
    }
    
    // AsyncStream to provide the preview frames
    private var addToPreviewStream: ((CGImage) -> Void)?
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    // CameraManager initializer
    override init() {
        super.init()
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    // Configure the camera session
    private func configureSession() async {
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera) else { return }
        
        self.deviceInput = deviceInput  // Initialize deviceInput here
        
        captureSession.beginConfiguration()
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard captureSession.canAddInput(deviceInput) else {
            print("Unable to add device input to capture session.")
            return
        }
        
        guard captureSession.canAddOutput(videoOutput!) else {
            print("Unable to add video output to capture session.")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput!)
    }
    
    // Start the camera session
    private func startSession() async {
        guard await isAuthorized else { return }
        captureSession.startRunning()
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
}
