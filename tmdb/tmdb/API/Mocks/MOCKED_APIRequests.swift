//  MOCKED_APIRequests.swift
//  tmdb

#if DEBUG

import Foundation

class MOCKED_APIRequests_Success: APIRequest {

    func get(url: URL, onSuccess: @escaping APIResponseSuccess, onError: @escaping ErrorClosure) {

        if url == TMDB.resourceURL.configuration.URLValue {
            onSuccess(MOCKED_APIResponses.MOCKED_ConfigurationResponse.data(using: .utf8)!)
            return
        } else if url == TMDB.resourceURL.discoverMovies.URLValue {
            onSuccess(MOCKED_APIResponses.MOCKED_DiscoverMovies_pg0.data(using: .utf8)!)
            return
        } else if url == TMDB.resourceURL.genres.URLValue {
            onSuccess(MOCKED_APIResponses.MOCKED_GenresResponse.data(using: .utf8)!)
            return
        }
        onError(CustomError.error(message: "No MOCKED response found for URL \(url)"))
    }
}


#endif
