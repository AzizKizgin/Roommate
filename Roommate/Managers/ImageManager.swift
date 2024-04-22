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
        DispatchQueue.global().async {
            if let imageData = img.jpegData(compressionQuality: 1) {
                let base64String = imageData.base64EncodedString()
                DispatchQueue.main.async {
                    completion(base64String)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
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
        DispatchQueue.global().async {
            if let imageData = Data(base64Encoded: imgString) {
                DispatchQueue.main.async {
                    completion(imageData)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func convertStringArrayToImageDataArray(for imgStrings: [String], completion: @escaping ([Data]) -> Void) {
        DispatchQueue.global().async {
            var imageDataArray: [Data] = []
            
            for imgString in imgStrings {
                if let imageData = Data(base64Encoded: imgString) {
                    imageDataArray.append(imageData)
                }
            }
            
            DispatchQueue.main.async {
                completion(imageDataArray)
            }
        }
    }
}
