//
//  PhotoLibraryView.swift
//  Challange2
//
//  Created by Can Dindar on 13/11/24.
//

import SwiftUI

struct PhotoLibraryView {
  
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var showProgress: Bool
    @Binding var commonName: String
    @Binding var plantName: String
    @Binding var probability: String
  
    func makeCoordinator() -> Coordinator {
        NSLog("PhotoLibraryView makeCoordinator invoked")
        return Coordinator(isShown: $isShown, image: $image, showProgress: $showProgress, commonName: $commonName, plantName: $plantName, probability: $probability)
    }
}

extension PhotoLibraryView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoLibraryView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        NSLog("PhotoLibraryView UIImagePickerController instantiated")
        picker.delegate = context.coordinator
        NSLog("PhotoLibraryView UIImagePickerController delegate coordinator assigned")
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        return picker
    }
  
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<PhotoLibraryView>) {
    
    }
}
