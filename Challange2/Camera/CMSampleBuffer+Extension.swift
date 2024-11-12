//
//  CMSampleBuffer+Extension.swift
//  Challange2
//
//  Created by Can Dindar on 11/11/24.
//

import AVFoundation
import CoreImage

extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelbuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelbuffer else {
            return nil
        }
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}
