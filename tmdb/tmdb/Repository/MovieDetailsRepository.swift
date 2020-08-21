//
//  MovieDetailsRepository.swift
//  tmdb

import Foundation
import RxSwift

enum MovieDetailsRepositoryStatus {
    case success(details: MovieDetails)
    case loading
    case error(error: Error)

    static func == (lhs: MovieDetailsRepositoryStatus, rhs: MovieDetailsRepositoryStatus) -> Bool {
        switch (lhs, rhs) {
        case let (.success(details: aaa),   .success(details: bbb)):
            return aaa.id == bbb.id //more checking can be added here
        case (.loading, .loading):
            return true
        case let (.error(error: errorA), .error(error: errorB)):
            return errorA.localizedDescription == errorB.localizedDescription
        default:
            return false
        }
    }
}


protocol MovieDetailsRepositoryProtocol {
    var state: Observable<MovieDetailsRepositoryStatus> { get }
    func fetch()
}

class MovieDetailsRepository: MovieDetailsRepositoryProtocol {

    //*************************************************
    // MARK: - Properties
    //*************************************************
    private let _api: APIRequest
    private let _movie: Movie
    private let _state = BehaviorSubject<MovieDetailsRepositoryStatus>(value: .loading)
    var state: Observable<MovieDetailsRepositoryStatus> { return _state.asObserver() }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(movie: Movie, api: APIRequest = AFRequest()) {
        _movie = movie
        _api = api
        fetch()
    }

    func fetch() {
        _state.onNext(.loading)
        _api.get(url: TMDB.resourceURL.movieDetails(movieId: _movie.id).URLValue,
                 onSuccess: { [weak self] (data) in

                    if let object = data.mapObject(MovieDetails.self) {
                        self?._state.onNext(.success(details: object))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))

        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }
    }

}
