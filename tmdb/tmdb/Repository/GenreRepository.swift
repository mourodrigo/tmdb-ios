//  CategoryRepository.swift
//  tmdb

import Foundation
import RxSwift

enum GenreRepositoryStatus {
 case success(genres: [Genre])
 case loading
 case error(error: Error)
}


protocol GenreRepositoryProtocol {
    var state: Observable<GenreRepositoryStatus> { get }
    func fetch()
}

class GenreRepository: GenreRepositoryProtocol {

    //*************************************************
    // MARK: - Properties
    //*************************************************
    private let _api: APIRequest
    private let _state = BehaviorSubject<GenreRepositoryStatus>(value: .loading)
    var state: Observable<GenreRepositoryStatus> { return _state.asObserver() }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(api: APIRequest) {
        _api = api
        fetch()
    }

    func fetch() {
        _state.onNext(.loading)
        _api.get(url: TMDB.resourceURL.genres.URLValue,
                onSuccess: { [weak self] (data) in
                    if let object = data.mapObject(Genres.self) {
                        self?._state.onNext(.success(genres: object.all))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))
        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }
    }

}
