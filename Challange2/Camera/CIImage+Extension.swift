//
//  CIImage+Extension.swift
//  Challange2
//
//  Created by Can Dindar on 11/11/24.
//

import CoreImage

extension CIImage {
    var cgImage: CGImage? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: extent) else { return nil
        }
        return cgImage
    }
}
