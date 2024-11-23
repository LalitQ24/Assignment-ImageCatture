//
//  CombineDataService.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import Combine
import Foundation

enum APIBaseUrl: String {
    case staging = "https://www.clippr.ai/api/upload'"
    case dev = ""
}


extension ObjectWithImage {
    struct UploadError: Error {
        var object: ObjectWithImage
        var error: Error
    }
}

struct CombineDataService {
    enum Errors: Error {
        case badStatusCode(Int)
    }
    
    private func request(for object: ObjectWithImage) throws -> URLRequest {
        let url = URL(string: APIBaseUrl.staging.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(object)
        return request
    }
    
    public func upload(_ object: ObjectWithImage) -> AnyPublisher<ObjectWithImage, ObjectWithImage.UploadError> {
        return Just(object)
            .tryMap(self.request(for:))
            .flatMap({
                URLSession.shared.dataTaskPublisher(for: $0)
                    .mapError { $0 as Error }
            })
            .map { $0.response as! HTTPURLResponse }
            .flatMap({
                return $0.statusCode == 200
                ? Result<Void, Error>.Publisher(())
                : Result<Void, Error>.Publisher(Errors.badStatusCode($0.statusCode))
            })
            .map { object }
            .mapError { ObjectWithImage.UploadError(object: object, error: $0) }
            .eraseToAnyPublisher()
    }
}
