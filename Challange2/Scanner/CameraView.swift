//
//  CameraView.swift
//  Challange2
//
//  Created by Can Dindar on 13/11/24.
//

import SwiftUI

struct CameraView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var showProgress: Bool
    @Binding var commonName: String
    @Binding var plantName: String
    @Binding var probability: String
    
    func makeCoordinator() -> Coordinator {
        NSLog("CameraView makeCoordinator invoked")
        return Coordinator(isShown: $isShown, image: $image, showProgress: $showProgress, commonName: $commonName, plantName: $plantName, probability: $probability)
    }
}

extension CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        NSLog("CameraView UIImagePickerController instantiated")
        picker.delegate = context.coordinator
        NSLog("CameraView UIImagePickerController delegate coordinator assigned")
        picker.sourceType = UIImagePickerController.SourceType.camera
        return picker
    }
  
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<CameraView>) {
    
    }
}
