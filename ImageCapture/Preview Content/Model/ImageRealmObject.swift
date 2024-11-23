//
//  ImageRealmObject.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//
import RealmSwift
import Foundation
import SwiftUI

class ImageRealmObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var imageName: String
    @Persisted var imagePath: String
    @Persisted var imageCaptureDate: Date
}

