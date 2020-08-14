//
//  DiscoverMoviesCoordinator.swift
//  tmdb

import UIKit

protocol DiscoverMoviesCoordinatorProtocol: BaseCoordinatorProtocol {

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

        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.push(MoviesListCollectionCoordinator())
        }
    }

}
