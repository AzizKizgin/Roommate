//
//  ImageManager.swift
//  Roommate
//
//  Created by Aziz Kızgın on 9.04.2024.
//

import Foundation
import SwiftUI

class ImageManager {
    
    static let shared = ImageManager()
    private init() {}
    
    func convertImageToString(for img: UIImage, completion: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            let imageData = img.jpegData(compressionQuality: 1)
            let base64String = imageData?.base64EncodedString()
            DispatchQueue.main.async {
                completion(base64String)
            }
        }
    }
    
    func convertStringToImage(for imgString: String) -> UIImage? {
        if let imageData = Data(base64Encoded: imgString),
           let image = UIImage(data: imageData){
            return image
        }
        return nil
    }
    
    func convertStringToImageData(for imgString: String, completion: @escaping (Data?) -> Void) {
        Task {
            if let imageData = Data(base64Encoded: imgString) {
                completion(imageData)
            }
            completion(nil)
        }
    }
}
