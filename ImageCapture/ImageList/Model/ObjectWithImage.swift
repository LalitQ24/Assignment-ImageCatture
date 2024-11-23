//
//  ObjectWithImage.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 23/11/24.
//

import SwiftUI
import Combine

struct ObjectWithImage: Encodable {
    let id: UUID
    let name: String
    let imageData: Data
    let imageCatureDate: Date
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case imageData
        case imageCatureDate
    }
}

extension Publishers {
    static let uploadObjectQueue: PassthroughSubject<ObjectWithImage, Never> = PassthroughSubject<ObjectWithImage, Never>()
}
