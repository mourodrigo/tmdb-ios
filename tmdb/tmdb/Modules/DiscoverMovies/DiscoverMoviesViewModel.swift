//
//  DiscoverMoviesViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

enum DiscoverMoviesViewModelStatus {
    case new(genre: Genre)
    case loading
    case error(error: Error)
}

protocol DiscoverMoviesViewModelProtocol: BaseViewModelProtocol {
    var state: Observable<DiscoverMoviesViewModelStatus> { get }
}

class DiscoverMoviesViewModel: BaseViewModel, DiscoverMoviesViewModelProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private let _disposeBag = DisposeBag()
    private weak var _coordinator: DiscoverMoviesCoordinatorProtocol?

    private let _genreRepository: GenreRepositoryProtocol

    private let _state = BehaviorSubject<DiscoverMoviesViewModelStatus>(value: .loading)
    var state: Observable<DiscoverMoviesViewModelStatus> { return _state.asObserver() }

    private let _genres = BehaviorSubject<[Genre]>(value: [Genre]())
    var genres: Observable<[Genre]> { return _genres.asObserver() }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: DiscoverMoviesCoordinatorProtocol, genreRepository: GenreRepositoryProtocol) {
        _coordinator = coordinator
        _genreRepository = genreRepository
        super.init()
        DispatchQueue.global().asyncAfter(deadline: .now()+1) {
            self.bind()
        }
    }

    func bind() {
        _state.onNext(.loading)

        //*************************************************
        // MARK: - DISCOVER MOVIES
        //*************************************************

//        _discoverRepository.state.bind { [weak self] (status) in
//            switch status {
//            case .updated(genre: let genre, _):
//                self?._state.onNext(.updated(genre: genre))
//            case .idle:
//                break // TODO
//            case .error(error: let error):
//                break //TODO
//            case .loading:
//                <#code#>
//            }
//        }.disposed(by: _disposeBag)

        //*************************************************
        // MARK: - GENRE REPOSITORY
        //*************************************************



        _genreRepository.state.bind { [weak self] (genreStatus) in
            switch genreStatus {
            case .success(genres: let list):
                self?.handleWhenLoaded(genres: list)

            case .loading:
                self?._state.onNext(.loading)

            case .error(error: let error):
                print("error loading") //todo SHOW ERROR
            }
        }.disposed(by: _disposeBag)

        _genreRepository.fetch()

    }

    private func handleWhenLoaded(genres: [Genre]) {
        self._genres.onNext(genres)
        for genre in genres {
            self._state.onNext(.new(genre: genre))
            self.handleFetch(genre: genre)
        }
    }

    private func handleFetch(genre: Genre) {
//        let firstLoading = 150
//        self._state.onNext(.fetching(genre: genre))
//        self._discoverRepository.fetch(genre: genre, resultIndex: firstLoading)
    }


    //************************************************
    // MARK: - Handle Actions
    //************************************************

}
