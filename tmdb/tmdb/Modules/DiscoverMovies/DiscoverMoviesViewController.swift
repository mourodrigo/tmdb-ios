//  DiscoverMoviesViewController.swift
//  tmdb

import UIKit
import RxSwift
import RxCocoa
import Cartography

class DiscoverMoviesViewController: BaseViewController {
    //************************************************
    // MARK: - @IBOutlets
    //************************************************
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewContainer: UIStackView!

    //************************************************
    // MARK: - Private Properties
    //************************************************

    private weak var _viewModel: DiscoverMoviesViewModelProtocol!
    override var viewModel: BaseViewModelProtocol { return _viewModel }
    private let _disposeBag = DisposeBag()

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: DiscoverMoviesViewModelProtocol) {
        _viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOnLoad()
    }

    //************************************************
    // MARK: - Setup
    //************************************************

    private func setupOnLoad() {

        _viewModel.state.bind { (viewModelState) in
            switch viewModelState {
            case .new(genreList: let list):
                self.stackViewContainer.addArrangedSubview(list.viewController.view)
                Cartography.constrain(list.viewController.view, self.view) { (listView, container) in
                    listView.height == 150
                }
            case .loading:
                print("VIEW MODEL LOADING")
            case .error(error: let error):
                print("VIEW MODEL ERROR \(error)")
            }
        }.disposed(by: _disposeBag)

    }
}
