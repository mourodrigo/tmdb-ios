//  String+.swift
// tmdb

import Foundation

extension String {

    /// UUID -> Universally Unique IDentifier
    static func getUUID() -> String {
        return UUID().uuidString
    }

}
