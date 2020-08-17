//  Coordinator.swift
//  tmdb

import UIKit
import RxSwift

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
    private var _disposeBag = DisposeBag()

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    override init() {
        super.init()

        _viewModel = ViewModel(coordinator: self)
        _viewController = ViewController(viewModel: _viewModel)

        SharedLocator.shared.configurationRepository.state.bind { (status) in
            switch status {

            case .success(configuration: _):
                self.presentDiscoverMovies()
            case .loading: break

            case .error(error:  _):
                DispatchQueue.global().asyncAfter(deadline: .now()+1) {
                    //trying to fetch configuration again if something happend
                    //like opening the app without internet
                    SharedLocator.shared.configurationRepository.fetch()
                }
            }
        }.addDisposableTo(_disposeBag)


    }

    func presentDiscoverMovies() {
        let discover = DiscoverMoviesCoordinator()
        self.present(discover)
    }

}
