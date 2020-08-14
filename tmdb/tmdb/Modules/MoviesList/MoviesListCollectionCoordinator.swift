//  MoviesListCoordinator.swift
//  tmdb

import UIKit

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


    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(genre: Genre) {
        super.init()

        _viewModel = MoviesListCollectionViewModel.init(coordinator: self,
                                                        genre: genre,
                                                        discoverRepository: DiscoverMoviesRepository(api: AFRequest()))
        _viewController = MoviesListCollectionViewController(viewModel: _viewModel)
    }

}
