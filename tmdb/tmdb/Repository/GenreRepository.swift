//  CategoryRepository.swift
//  tmdb

import Foundation
import RxSwift

class GenreRepository {

    enum Status {
     case success
     case loading
     case error(error: Error)
    }

    //*************************************************
    // MARK: - Properties
    //*************************************************

    private let _state = BehaviorSubject<Status>(value: .loading)
    var state: Observable<Status> { return _state.asObserver() }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(api: APIRequest) {
        api.get(url: TMDB.resourceURL.genres, onSuccess: <#T##APIResponseSuccess##APIResponseSuccess##(Data) -> Void#>, onError: <#T##ErrorClosure##ErrorClosure##(Error) -> Void#>)
    }

}
