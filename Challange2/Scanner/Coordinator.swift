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
        guard let unwrappedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image was selected.")
            return
        }
        
        Task {
            await self.postData(image: unwrappedImage) { jsonData, error in
                if let error = error {
                    print("Error in postData: \(error.localizedDescription)")
                    return
                }
                
                guard let jsonData = jsonData else {
                    print("No data received from API.")
                    return
                }
                
                if let suggestions = jsonData["suggestions"] as? [[String: AnyObject]],
                   let firstSuggestion = suggestions.first,
                   let plantName = firstSuggestion["plant_name"] as? String,
                   let plantDetails = firstSuggestion["plant_details"] as? [String: AnyObject],
                   let commonNames = plantDetails["common_names"] as? [String],
                   let commonName = commonNames.first,
                   let probabilityValue = firstSuggestion["probability"] as? Double {
                    
                    print("Plant name: \(plantName), Common name: \(commonName), Probability: \(probabilityValue)")
                    
                    let confidenceThreshold = 0.20
                    self.probability = "Confidence: " + String(format: "%.1f", probabilityValue * 100.0) + "%"
                    
                    let category = probabilityValue >= confidenceThreshold ? "Cactus" : "unclassified"
                    
                    // Guarda la imagen en la carpeta correspondiente
                    let fileName = self.getNextImageFileName(for: category)
                    if let fileURL = self.saveImageToDocuments(image: unwrappedImage, category: category, fileName: fileName) {
                        print("Image classified and saved at \(fileURL)")
                    }

                    
                    if probabilityValue >= confidenceThreshold {
                        self.plantName = "\"\(plantName)\""
                        self.commonName = commonName
                    } else {
                        self.commonName = "Prediction unreliable"
                    }
                } else {
                    print("Unable to parse suggestions from JSON data.")
                }
                
                self.showProgress = false
            }
        }
        
        imageInCoordinator = Image(uiImage: unwrappedImage)
        isCoordinatorShown = false
        showProgress = true
    }
    
    func getNextImageFileName(for category: String) -> String {
        let defaults = UserDefaults.standard
        let key = "imageCounter-\(category)"
        
        // Obtener el contador actual, si no existe se inicializa en 0
        let currentCounter = defaults.integer(forKey: key)
        let nextCounter = currentCounter + 1
        
        // Actualizar el contador en UserDefaults
        defaults.set(nextCounter, forKey: key)
        
        // Formatear el nombre del archivo
        return String(format: "image-%02d.jpg", nextCounter)
    }


    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker was cancelled.")
        isCoordinatorShown = false
        showProgress = false
    }
    
    func postData(image: UIImage, completionHandler: @escaping ([String: AnyObject]?, Error?) -> Void) async {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert image to JPEG data.")
            return
        }
        
        let parameters: [String: Any] = [
            "api_key": "Ge21T0LAP11hWJBV0ql5fpHHleOGQj5AuqLd2zPT1eEvg0vzjd",
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
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Non-200 HTTP response.")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                //print("Response JSON: \(json)")
                completionHandler(json, nil)
            } else {
                print("Failed to decode JSON response.")
                completionHandler(nil, nil)
            }
        } catch {
            print("Failed to complete URL session: \(error.localizedDescription)")
            completionHandler(nil, error)
        }
    }
    
    func saveImageToDocuments(image: UIImage, category: String, fileName: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert UIImage to JPEG data.")
            return nil
        }
        
        let fileManager = FileManager.default
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let categoryURL = documentsURL.appendingPathComponent(category)
            
            // Crea el directorio si no existe
            if !fileManager.fileExists(atPath: categoryURL.path) {
                try fileManager.createDirectory(at: categoryURL, withIntermediateDirectories: true, attributes: nil)
            }
            
            let fileURL = categoryURL.appendingPathComponent(fileName)
            try data.write(to: fileURL, options: .atomic)
            print("Image saved successfully at \(fileURL.path)")
            return fileURL
        } catch {
            print("Error saving image to local storage: \(error.localizedDescription)")
            return nil
        }
    }

}
