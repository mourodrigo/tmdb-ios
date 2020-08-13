//  DiscoverMoviesRepository.swift
//  tmdb

import Foundation
import RxSwift

enum DiscoverMoviesRepositoryStatus {
    case updated(genre: Genre, movies: [Movie])
    case idle
    case error(error: Error)

    static func == (lhs: DiscoverMoviesRepositoryStatus, rhs: DiscoverMoviesRepositoryStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case let (.error(error: errorA), .error(error: errorB)):
            return errorA.localizedDescription == errorB.localizedDescription
        case (.updated(genre: let genreAaa, movies: let moviesAaa), .updated(genre: let genreBbb, movies: let moviesBbb)):
             //more checking can be added here like a array compare of all movies
            return moviesAaa.count == moviesBbb.count && genreAaa.id == genreBbb.id
        default:
            return false
        }
    }
}


protocol DiscoverMoviesRepositoryProtocol {
    var state: Observable<DiscoverMoviesRepositoryStatus> { get }
    func fetch(genre: Genre, resultIndex: Int)
}

class DiscoverMoviesRepository: DiscoverMoviesRepositoryProtocol {

    //*************************************************
    // MARK: - Properties
    //*************************************************
    private let _api: APIRequest
    private let _state = BehaviorSubject<DiscoverMoviesRepositoryStatus>(value: .idle)
    var state: Observable<DiscoverMoviesRepositoryStatus> { return _state.asObserver() }

    private var _discoverMovies = [Int:[Movie]]()

    private var _discoverMoviesGenreStates = [Int:GenreStates]()

    //    private var _discoverMoviesGenreStates = BehaviorSubject<[Int:GenreStates]>(value: [Int:GenreStates]())
    //    var discoverMoviesGenreStates: Observable<[Int:GenreStates]> { return _discoverMoviesGenreStates.asObserver() }


    struct GenreStates {
        let lastPage: Int?
        let totalResults: Int?
        let totalPages: Int?
        let isLoading: Bool
    }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(api: APIRequest) {
        _api = api
    }

    func clean() {
        _discoverMovies = [Int: [Movie]]()
    }

    private func hasLoadedEnough(of genre: Genre, resultIndex: Int) -> Bool {
        return resultIndex+1 >= _discoverMovies[genre.id]?.count ?? 0 ? false : true
    }

    private func setLoading(for genre: Genre) -> Bool {
        _discoverMoviesGenreStates[genre.id]?.isLoading == true
    }

    func fetch(genre: Genre, resultIndex: Int) {

        if self._discoverMovies[genre.id] == nil  {
            self._discoverMovies[genre.id] = [Movie]()
        }

        if hasLoadedEnough(of: genre, resultIndex: resultIndex), let movies = _discoverMovies[genre.id] {
            self._state.onNext(.updated(genre: genre, movies: movies))
            return
        }

        // checking which page to fetch
        var lastPageNumber: Int {
            let lastPageFetched = _discoverMoviesGenreStates[genre.id]?.lastPage
            return lastPageFetched == nil ? 0 : lastPageFetched! + 1
        }

        _api.get(url: TMDB.resourceURL.discoverMovies(genreId: genre.id).URLValue(page: lastPageNumber),
                onSuccess: { [weak self] (data) in
                    guard let self = self else { return }

                    if let object = data.mapObject(DiscoverMovies.self) {

                        self._discoverMoviesGenreStates[genre.id] = GenreStates(lastPage: lastPageNumber,
                                                                        totalResults: object.totalResults,
                                                                        totalPages: object.totalPages,
                                                                        isLoading: false)

                        self._discoverMovies[genre.id]?.append(contentsOf: object.all)

                        self.fetch(genre: genre, resultIndex: resultIndex)
                        return
                    }
        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }








    }

//    func fetch(page: Int = 0) {
//        _state.onNext(.loading)
//        _api.get(url: TMDB.resourceURL.discoverMovies.URLValue(page: page),
//                onSuccess: { [weak self] (data) in
//                    if let object = data.mapObject(DiscoverMovies.self) {
//                        self?._state.onNext(.success(movies: object.all))
//                        return
//                    }
//                    self?._state.onNext(.error(error: CustomError.mappingResponse))
//        }) { [weak self] (error) in
//            self?._state.onNext(.error(error:
//                    CustomError.serverError(details: error.localizedDescription)))
//        }
//    }

}
