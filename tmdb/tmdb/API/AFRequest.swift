//  AFRequest.swift
//  tmdb

import Foundation
import Alamofire

class AFRequest: APIRequest {

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
