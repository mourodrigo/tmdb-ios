//  API.swift
//  tmdb

import Foundation

//for encodable objects
protocol BiCodable: (Decodable & Encodable) {}

protocol APIRequest {
    func get(url: URL, onSuccess: @escaping APIResponseSuccess, onError: @escaping ErrorClosure)
}

typealias APIResponseSuccess = (_ json: Data) -> Void
