//
//  ImageHelper.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import Foundation
import SwiftUI
import Realm
import RealmSwift

class ImageHelper {
    
    func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL.path
        
    }
    
    func saveSelectedImage(image: UIImage, name: String) {
        let imageFileName:String = name
        let imagePath = fileInDocumentsDirectory(imageFileName)
        saveImage(image, path: imagePath)
    }
    
    func loadSaveImage(imageName: String) -> UIImage? {
        let imageName:String = imageName
        let imagePath = fileInDocumentsDirectory(imageName)
        if let loadedImage = self.loadImageFromPath(imagePath) {
            return loadedImage
        } else {
            print("Couldn't Load: \(imageName)")
            return nil
        }
    }
    
    func loadImagePath(imageName: String) -> String? {
        let imageName:String = imageName
        let imagePath = fileInDocumentsDirectory(imageName)
        return imagePath
    }
    
    func getImageFromPath(imagePath: String) -> UIImage? {
        if let loadedImage = self.loadImageFromPath(imagePath) {
            return loadedImage
        } else {
           // print("Couldn't Load: \"")
            return nil
        }
    }
    
    func saveImage(_ image: UIImage, path: String ) {
        if let jpgData = image.jpegData(compressionQuality: 1.0) {
            try? jpgData.write(to: URL(fileURLWithPath: path), options: [.atomic])
            let imageStore = ImageStore()
            imageStore.imagePath = path
            
        }
        
    }
    func loadImageFromPath(_ path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
          //  print("couldn't find image at path: \(path)")
        }
        return image
    }
}


class ImageStore {
    var imagePath: String?
}
