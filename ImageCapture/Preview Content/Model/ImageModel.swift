//
//  ImageModel.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: String?
    var imageName: String?
    var imagePath: String?
    var imageCaptureDate: Date?
    init(imageRealmObject: ImageRealmObject) {
        self.id = imageRealmObject.id.stringValue
        self.imageName = imageRealmObject.imageName
        self.imagePath = imageRealmObject.imagePath
        self.imageCaptureDate = imageRealmObject.imageCaptureDate
    }
}

struct UploadDataModel: Identifiable {
    var id: String?
    var isUpload: Bool?
}
