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
    @IBOutlet weak var ratingStars: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

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
        releaseDateLabel.text = _viewModel.releaseDate
        popularityLabel.text = _viewModel.popularity
        genreLabel.text = _viewModel.genre

        _viewModel.posterImage.bind { [weak self] (image) in
            self?.imageView.image = image
        }.disposed(by: _disposeBag)

    }

    //saving time by using emojis... sorry for it
    private func setRatingStars() {
        var ratingText = ""
        for _ in 0..._viewModel.rating {
            ratingText = ratingText.appending("⭐️")
        }
        ratingStars.text = ratingText
    }

}
