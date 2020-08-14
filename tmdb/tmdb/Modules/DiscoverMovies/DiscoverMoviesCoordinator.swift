//
//  DiscoverMoviesCoordinator.swift
//  tmdb

import UIKit

protocol DiscoverMoviesCoordinatorProtocol: BaseCoordinatorProtocol {
    func pushDetails(movie: Movie, genre: Genre)
}

class DiscoverMoviesCoordinator: BaseCoordinator, DiscoverMoviesCoordinatorProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private var _viewModel: DiscoverMoviesViewModel!
    private var _viewController: DiscoverMoviesViewController!
    private var _navigationController: UINavigationController!

    override var viewController: UIViewController { return _viewController }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    override init() {
        super.init()

        let api = AFRequest()

        _viewModel = DiscoverMoviesViewModel(coordinator: self,
                                             genreRepository: GenreRepository(api: api))
        
        _viewController = DiscoverMoviesViewController(viewModel: _viewModel)
        _navigationController = UINavigationController(rootViewController: _viewController)

    }

    func pushDetails(movie: Movie, genre: Genre) {
        let details = MovieDetailsCoordinator(movie: movie, genre: genre, api: AFRequest())
        self.push(details)
    }

}
