//
//  CombineDataService.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import Combine
import Foundation

class CombineDataService {
    func uploadImage()-> AnyPublisher<[UploadDataModel], Error> {
        let api  = ""
        let url = URL(string: api)
        return URLSession.shared.dataTask(with: url!)
            .map({$0.data})
            .decode(type: [UploadDataModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
