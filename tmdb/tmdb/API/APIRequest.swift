//  API.swift
//  tmdb

import Foundation
import Alamofire

protocol BiCodable: (Decodable & Encodable) {}

protocol APIRequest {
    func get(url: URL, onSuccess: @escaping APIResponseSuccess, onError: @escaping ErrorClosure)
}

typealias APIResponseSuccess = (_ json: Data) -> Void

class AFRequest {

    func get(url: URL, onSuccess: @escaping APIResponseSuccess, onError: @escaping ErrorClosure) {
        print("Request to \(url)")
        
        AF.request(url).responseData { (response) in
            DispatchQueue.global().async {
                if let error = response.error {
                    onError(error)
                    return
                }
                guard let data = response.value else {
                    onError(CustomError.serverError(details: "Empty Response for \(url)"))
                    return
                }
                onSuccess(data)
            }
        }
    }
}
