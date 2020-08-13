//
//  DiscoverMoviesViewController.swift
//  tmdb

import UIKit
import RxSwift
import RxCocoa

class DiscoverMoviesViewController: BaseViewController {
    //************************************************
    // MARK: - @IBOutlets
    //************************************************

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

    }

}
