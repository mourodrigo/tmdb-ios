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
    private var _navigationController: UINavigationController!

    override var viewController: UIViewController { return _viewController }
//    override var viewControllerToPush: UIViewController { fatalError("MoviesListCollectionCoordinator can't be pushed") }
    override var navigationController: UINavigationController? {
        return _navigationController
    }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    override init() {
        super.init()

        _viewModel = MoviesListCollectionViewModel(coordinator: self)
        _viewController = MoviesListCollectionViewController(viewModel: _viewModel)
        _navigationController = UINavigationController(rootViewController: _viewController)
    }

}
