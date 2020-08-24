//  VideoRepository.swift
//  tmdb

import Foundation
import RxSwift

enum VideoRepositoryStatus {
    case success(content: VideoResponse)
    case loading
    case error(error: Error)

    static func == (lhs: VideoRepositoryStatus, rhs: VideoRepositoryStatus) -> Bool {
        switch (lhs, rhs) {
        case let (.success(content: aaa),   .success(content: bbb)):
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


protocol VideoRepositoryProtocol {
    var state: Observable<VideoRepositoryStatus> { get }
    func fetch()
}

class VideoRepository: VideoRepositoryProtocol {

    //*************************************************
    // MARK: - Properties
    //*************************************************
    private let _api: APIRequest
    private let _movie: Movie
    private let _state = BehaviorSubject<VideoRepositoryStatus>(value: .loading)
    var state: Observable<VideoRepositoryStatus> { return _state.asObserver() }

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
        _api.get(url: TMDB.resourceURL.videos(movieId: _movie.id).URLValue,
                 onSuccess: { [weak self] (data) in

                    if let object = data.mapObject(VideoResponse.self) {
                        self?._state.onNext(.success(content: object))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))

        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }
    }

}
