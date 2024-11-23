//
//  LegacyImageUpload.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 23/11/24.
//
import Combine
import SwiftUI
import Foundation

struct LegacyImageUpload {
    public func uploadImageData(_ data: Data) -> Future<Void, Error> {
        return Future { promise in
            self.upload(data: data) { (error) in
                if let error = error { promise(.failure(error)) }
                else { promise(.success(())) }
            }
        }
    }
    
    private func upload(data: Data, completion: @escaping (_ error: Error?) -> Void) {
        fatalError("some error")
    }
}

extension LegacyImageUpload {
    public func upload(_ object: ObjectWithImage) -> AnyPublisher<ObjectWithImage, ObjectWithImage.UploadError> {
        return uploadImageData(object.imageData)
            .map { object }
            .mapError { ObjectWithImage.UploadError(object: object, error: $0) }
            .eraseToAnyPublisher()
    }
}
