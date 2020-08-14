//
//  MovieDetailsViewController.swift
//  tmdb

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: BaseViewController {
    //************************************************
    // MARK: - @IBOutlets
    //************************************************

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    //************************************************
    // MARK: - Private Properties
    //************************************************

    private weak var _viewModel: MovieDetailsViewModelProtocol!
    override var viewModel: BaseViewModelProtocol { return _viewModel }
    private let _disposeBag = DisposeBag()

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: MovieDetailsViewModelProtocol) {
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

        titleLabel.text = _viewModel.title
        overviewLabel.text = _viewModel.overview

        _viewModel.posterImage.bind { [weak self] (image) in
            self?.imageView.image = image
        }.disposed(by: _disposeBag)
    }

}
