//  Data+.swift
//  tmdb

import Foundation

public extension Data {
    func mapObject<T: Codable>(_ resultType: T.Type) -> T {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch let error {
            return error as! T
        }
    }
}
