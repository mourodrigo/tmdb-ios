//  MovieDetailsCoordinator.swift
//  tmdb

import UIKit

protocol MovieDetailsCoordinatorProtocol: BaseCoordinatorProtocol {

}

class MovieDetailsCoordinator: BaseCoordinator, MovieDetailsCoordinatorProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private var _viewModel: MovieDetailsViewModel!
    private var _viewController: MovieDetailsViewController!
    private var _navigationController: UINavigationController!

    override var viewController: UIViewController { return _viewController }

    override var navigationController: UINavigationController? {
        return _viewController.navigationController
    }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(movie: Movie, genre: Genre) {
        super.init()
        _viewModel = MovieDetailsViewModel(coordinator: self, movie: movie, genre: genre)
        _viewController = MovieDetailsViewController(viewModel: _viewModel)
    }

}
