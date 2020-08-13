//  CategoryRepository.swift
//  tmdb

import Foundation
import RxSwift

enum GenreRepositoryStatus: Equatable {

    case success(genres: [Genre])
     case loading
     case error(error: Error)

    static func == (lhs: GenreRepositoryStatus, rhs: GenreRepositoryStatus) -> Bool {
        switch (lhs, rhs) {
        case let (.success(genres: aaa),   .success(genres: bbb)):
             //more checking can be added here
            return aaa.count == bbb.count && aaa.first?.id == bbb.first?.id
        case (.loading, .loading):
            return true
        case let (.error(error: errorA), .error(error: errorB)):
            return errorA.localizedDescription == errorB.localizedDescription
        default:
            return false
        }
    }


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
