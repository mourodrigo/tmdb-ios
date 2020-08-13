//  Coordinator.swift
//  tmdb

import UIKit

protocol CoordinatorProtocol: BaseCoordinatorProtocol {
    func presentDiscoverMovies()
}

class Coordinator: BaseCoordinator, CoordinatorProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private var _viewModel: ViewModel!
    private var _viewController: ViewController!
    override var viewController: UIViewController { return _viewController }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    override init() {
        super.init()

        _viewModel = ViewModel(coordinator: self)
        _viewController = ViewController(viewModel: _viewModel)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.presentDiscoverMovies()
        }
    }

    func presentDiscoverMovies() {
        let discover = DiscoverMoviesCoordinator()
        self.present(discover)
    }

}
