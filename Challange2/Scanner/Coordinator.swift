//
//  Coordinator.swift
//  Challange2
//
//  Created by Can Dindar on 13/11/24.
//

import SwiftUI
import Foundation

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    @Binding var showProgress: Bool
    @Binding var commonName: String
    @Binding var plantName: String
    @Binding var probability: String
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, showProgress: Binding<Bool>, commonName: Binding<String>, plantName: Binding<String>, probability: Binding<String>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
        _showProgress = showProgress
        _commonName = commonName
        _plantName = plantName
        _probability = probability
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrappedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        Task {
            await self.postData(image: unwrappedImage) { jsonData, error in
                guard let jsonData = jsonData else { return }
                
                // Safely unwrap the JSON data instead of force-casting
                if let suggestions = jsonData["suggestions"] as? [[String: AnyObject]],
                   let firstSuggestion = suggestions.first,
                   let plantName = firstSuggestion["plant_name"] as? String,
                   let plantDetails = firstSuggestion["plant_details"] as? [String: AnyObject],
                   let commonNames = plantDetails["common_names"] as? [String],
                   let commonName = commonNames.first,
                   let probabilityValue = firstSuggestion["probability"] as? Double {
                    
                    let confidenceThreshold = 0.20
                    self.probability = "Confidence: " + String(format: "%.1f", probabilityValue * 100.0) + "%"
                    
                    if probabilityValue >= confidenceThreshold {
                        self.plantName = "\"\(plantName)\""
                        self.commonName = commonName
                    } else {
                        self.commonName = "Prediction unreliable"
                    }
                }
                self.showProgress = false
            }
        }
        
        imageInCoordinator = Image(uiImage: unwrappedImage)
        isCoordinatorShown = false
        showProgress = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
        showProgress = false
    }
    
    func postData(image: UIImage, completionHandler: @escaping ([String: AnyObject]?, Error?) -> Void) async {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        
        let parameters: [String: Any] = [
            "api_key": "4bZ8n1qTZzWPIWwUHRm3GioZclDx10T6OP5J4W9mrWpwSzzMt9",
            "images": [imageData.base64EncodedString()],
            "modifiers": ["crops_fast", "similar_images", "health_all", "disease_similar_images"],
            "plant_language": "en",
            "plant_details": ["common_names"]
        ]
        
        let url = URL(string: "https://api.plant.id/v2/identify")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            // Directly decode JSON data
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                completionHandler(json, nil)
            }
        } catch {
            NSLog("Failed to complete URL session: \(error.localizedDescription)")
            completionHandler(nil, error)
        }
    }
}
