//  DiscoverMoviesRepository.swift
//  tmdb

import Foundation
import RxSwift

enum DiscoverMoviesRepositoryStatus {
    case updated(genre: Genre, movies: [Movie])
    case idle
    case loading
    case error(error: Error)

    static func == (lhs: DiscoverMoviesRepositoryStatus, rhs: DiscoverMoviesRepositoryStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
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

    private var _discoverMovies = [Movie]()

    private var _discoverMoviesGenreState = BehaviorSubject<GenreState>(value: GenreState.init(lastPage: nil, isLoading: false))
    var discoverMoviesGenreState: Observable<GenreState> { return _discoverMoviesGenreState.asObserver() }

    struct GenreState {
        let lastPage: Int?
        let isLoading: Bool
    }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(api: APIRequest) {
        _api = api
    }

    func clean() {
        _discoverMovies = [Movie]()
    }

    private func hasLoadedEnough(resultIndex: Int) -> Bool {
        return resultIndex+1 >= _discoverMovies.count ? false : true
    }

    private func setPageLoading(lastPage: Int, isLoading: Bool) {
        let state = GenreState(lastPage: lastPage, isLoading: isLoading)
        self._discoverMoviesGenreState.onNext(state)
        self._state.onNext(.loading)
    }

    func fetch(genre: Genre, resultIndex: Int) {

        if hasLoadedEnough(resultIndex: resultIndex){
            self._state.onNext(.updated(genre: genre, movies: _discoverMovies))
            return
        }

        // checking which page to fetch
        var pageToLoadNumber: Int {
            let lastPageFetched = try? _discoverMoviesGenreState.value().lastPage
            return lastPageFetched == nil ? 0 : lastPageFetched! + 1
        }

        setPageLoading(lastPage: pageToLoadNumber, isLoading: true)

        _api.get(url: TMDB.resourceURL.discoverMovies(genreId: genre.id).URLValue(page: pageToLoadNumber),
                onSuccess: { [weak self] (data) in
                    guard let self = self else { return }

                    if let object = data.mapObject(DiscoverMovies.self) {

                        self.setPageLoading(lastPage: pageToLoadNumber, isLoading: false)

                        self._discoverMovies.append(contentsOf: object.all)

                        self.fetch(genre: genre, resultIndex: resultIndex)
                        return
                    }
        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }

    }

}
