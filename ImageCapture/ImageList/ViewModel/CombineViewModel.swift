//
//  CombineViewModel.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import Combine
import Foundation
import SwiftUI

class CombineViewModel: ObservableObject {
    let objectsToUpload = PassthroughSubject<ObjectWithImage, Never>()
    let legacyUploader = LegacyImageUpload()
    let sevice = CombineDataService()
    
    func uploadImageToServer() {
        let _ = objectsToUpload
            .flatMap({
                self.legacyUploader.upload($0)
                    .flatMap { self.sevice.upload($0) }
                    .map { Result<ObjectWithImage, ObjectWithImage.UploadError>.success($0) }
                    .catch { Just(Result.failure($0)) }
            })
            .sink(receiveValue: {
                switch $0 {
                case .success(let object):
                    print("success")
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            })
        
    }
}


