//
//  DiscoverMoviesViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

enum DiscoverMoviesViewModelStatus {
    case new(genreList: MoviesListCollectionCoordinator)
    case loading
    case error(error: Error)
}

protocol DiscoverMoviesViewModelProtocol: BaseViewModelProtocol {
    var state: Observable<DiscoverMoviesViewModelStatus> { get }
    func handleReload()
    #if DEBUG
    func handleDebugMenu()
    #endif
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

    private var _lists = [MoviesListCollectionCoordinator]()

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

        _genreRepository.state.bind { [weak self] (genreStatus) in
            switch genreStatus {
            case .success(genres: let list):
                self?.handleWhenLoaded(genres: list)

            case .loading:
                self?._state.onNext(.loading)

            case .error(error: let _):
                print("error loading") //todo SHOW ERROR
            }
        }.disposed(by: _disposeBag)

        _genreRepository.fetch()

    }

    private func handleWhenLoaded(genres: [Genre]) {
        self._genres.onNext(genres)
        for genre in genres {
            guard let coordinator = self._coordinator else { return }
            let list = MoviesListCollectionCoordinator(genre: genre,
                                                       onMovieSelection: coordinator.pushDetails)
            _lists.append(list)
            self._state.onNext(.new(genreList: list))
        }
    }

    func handleReload() {
        _genreRepository.reload()
    }

    #if DEBUG
    func handleDebugMenu() {
        if let url = URL(string: "https://www.linkedin.com/in/mourodrigo") {
            UIApplication.shared.open(url)
        }

    }
    #endif



}
