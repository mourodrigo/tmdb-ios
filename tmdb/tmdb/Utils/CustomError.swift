//
//  CustomError.swift
//  tmdb

import Foundation
protocol ErrorProtocol: LocalizedError, CustomStringConvertible, CustomDebugStringConvertible {}

extension ErrorProtocol {
    var errorDescription: String? { return description }
    var localizedDescription: String { return description }
    var debugDescription: String { return description }
}

enum CustomError: ErrorProtocol {
    case noConnection
    case serverError(details: String?)
    case unexpectedServerResponse(details: String?)
    case error(message: String)

    var description: String {
        switch self {
        case .noConnection:
            return "No Connection"
        case .serverError(let details):
            return "An internal Server error has occurred. \(details ?? "")"
        case .unexpectedServerResponse(let details):
            return "Unexpected server response. \(details ?? "")"
        case .error(let message):
            return message
        }
    }
}

extension CustomError {

    /// An error that occurs during the decoding of a value (JSON).
    enum DecodingError: ErrorProtocol {

        /// An indication that the value used to decode isn't valid
        case wrongFormat
        /// An indication that the given key doens't exist on JSON.
        case keyNotFound(key: String)
        /// An indication that a non-optional value of the given type was expected, but a null value was found.
        case valueNotFound(forKey: String)

        var description: String {
            switch self {
            case .wrongFormat:
                return "The data couldn’t be read because it isn’t in the correct format."
            case .keyNotFound(let key):
                return "Expected key \"\(key)\" not found."
            case .valueNotFound(let forKey):
                return "Expected value for key \"\(forKey)\" not found."
            }
        }
    }
}
