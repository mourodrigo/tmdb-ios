//  MoviesListCoordinator.swift
//  tmdb

import UIKit

typealias MovieSelectionClosure = (_ movie: Movie, _ genre: Genre) -> Void

protocol MoviesListCollectionCoordinatorProtocol: BaseCoordinatorProtocol {

}

class MoviesListCollectionCoordinator: BaseCoordinator, MoviesListCollectionCoordinatorProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private var _viewModel: MoviesListCollectionViewModel!
    private var _viewController: MoviesListCollectionViewController!

    override var viewController: UIViewController { return _viewController }
    override var viewControllerToPush: UIViewController { fatalError("MoviesListCollectionCoordinator can't be pushed") }

    private var _onMovieSelection: MovieSelectionClosure

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(genre: Genre, onMovieSelection: @escaping MovieSelectionClosure) {
        _onMovieSelection = onMovieSelection
        super.init()
        _viewModel = MoviesListCollectionViewModel.init(coordinator: self,
                                                        genre: genre,
                                                        onMovieSelection: onMovieSelection,
                                                        discoverRepository: DiscoverMoviesRepository(api: AFRequest()))
        _viewController = MoviesListCollectionViewController(viewModel: _viewModel)
    }

}
