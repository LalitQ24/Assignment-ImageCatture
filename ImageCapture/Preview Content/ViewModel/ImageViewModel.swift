//
//  ImageViewModel.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import Foundation
import SwiftUI
import Realm
import RealmSwift


class ImageViewModel: ObservableObject {
    @ObservedResults(ImageRealmObject.self) var imageObjects
    @Published var imageListData: [ImageModel] = []
    @Published var imageHelper = ImageHelper()
    private var token: NotificationToken?
    
    init() {
        setUpRealm()
    }
    deinit {
        token?.invalidate()
    }
    
    private func setUpRealm() {
        do {
            let realm = try Realm()
            let results = realm.objects(ImageRealmObject.self)
            token  = results.observe({ [weak self] changes in
                self?.imageListData = results.map(ImageModel.init)
            })
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addImageInformation(imageName: String, image: UIImage, captureDate: Date) {
        let imageRealmObject = ImageRealmObject()
        imageRealmObject.imageName = imageName
        imageHelper.saveSelectedImage(image: image, name: imageName)
        let fecthImagePath = imageHelper.loadImagePath(imageName: imageName)
        imageRealmObject.imagePath = fecthImagePath ?? ""
        imageRealmObject.imageCaptureDate = captureDate
        $imageObjects.append(imageRealmObject)
    }
    
    func remove(id: String) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: id)
            if  let imageRealmObject = realm.object(ofType: ImageRealmObject.self, forPrimaryKey: objectId) {
                try realm.write {
                    realm.delete(imageRealmObject)
                }
            }
            
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}


