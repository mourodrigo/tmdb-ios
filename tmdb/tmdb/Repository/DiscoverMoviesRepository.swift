//  DiscoverMoviesRepository.swift
//  tmdb

import Foundation
import RxSwift

enum DisconverMoviesRepositoryStatus {
 case success(movies: [Movie])
 case loading
 case error(error: Error)
}


protocol DisconverMoviesRepositoryProtocol {
    var state: Observable<DisconverMoviesRepositoryStatus> { get }
    func fetch(page: Int)
}

class DisconverMoviesRepository: DisconverMoviesRepositoryProtocol {

    //*************************************************
    // MARK: - Properties
    //*************************************************
    private let _api: APIRequest
    private let _state = BehaviorSubject<DisconverMoviesRepositoryStatus>(value: .loading)
    var state: Observable<DisconverMoviesRepositoryStatus> { return _state.asObserver() }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(api: APIRequest) {
        _api = api
        fetch()
    }

    func fetch(page: Int = 0) {
        _state.onNext(.loading)
        _api.get(url: TMDB.resourceURL.discoverMovies.URLValue(page: page),
                onSuccess: { [weak self] (data) in
                    if let object = data.mapObject(DiscoverMovies.self) {
                        self?._state.onNext(.success(movies: object.all))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))
        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }
    }

}
