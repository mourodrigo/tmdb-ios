//  Coordinator.swift
//  tmdb

import UIKit

protocol CoordinatorProtocol: BaseCoordinatorProtocol {

}

class Coordinator: BaseCoordinator, CoordinatorProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private var _viewModel: ViewModel!
    private var _viewController: ViewController!
    private var _navigationController: UINavigationController!

    override var viewController: UIViewController { return _viewController }

    override var navigationController: UINavigationController? {
        return _navigationController
    }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    override init() {
        super.init()

        _viewModel = ViewModel(coordinator: self)
        _viewController = ViewController(viewModel: _viewModel)
        _navigationController = UINavigationController(rootViewController: _viewController)
    }

}
