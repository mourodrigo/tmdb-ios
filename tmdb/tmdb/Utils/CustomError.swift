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
    case mappingResponse

    var description: String {
        switch self {
        case .mappingResponse:
        return "Unexpected error mapping server response"
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
