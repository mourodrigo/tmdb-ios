//
//  MovieDetailsViewController.swift
//  tmdb

import UIKit
import RxSwift
import RxGesture

import RxCocoa
import Cartography

class MovieDetailsViewController: BaseViewController {
    //************************************************
    // MARK: - @IBOutlets
    //************************************************

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingStars: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var watchNowButton: UIButton!
    @IBOutlet weak var videosContainer: UIStackView!
    @IBOutlet weak var homePageButton: UIButton!

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

        _viewModel.taglineText.drive(onNext: { [weak self] (value) in
            self?.taglineLabel.text = value
        }).disposed(by: _disposeBag)

        _viewModel.watchNowURL.drive(onNext: { [weak self] (value) in
            self?.watchNowButton.isHidden = value == nil
        }).disposed(by: _disposeBag)

        watchNowButton.rx.tap.bind { [weak self] (_ ) in
            self?._viewModel.didTapWatchButton  ()
        }.disposed(by: _disposeBag)

        _viewModel.homePageURL.drive(onNext: { [weak self] (value) in
            self?.homePageButton.isHidden = value == nil
        }).disposed(by: _disposeBag)

        homePageButton.rx.tap.bind { [weak self] (_ ) in
            self?._viewModel.didTapHomePageButton()
        }.disposed(by: _disposeBag)

        _viewModel.videoThumbs.drive(onNext: setVideoThumbs(with:))
            .disposed(by: _disposeBag)

        setRatingStars()

    }

    private func setRatingStars() {
        //saving time by using emojis... (laughs)
        var ratingText = ""
        for index in 1...10 {
            ratingText = ratingText.appending(index > _viewModel.rating ? "☆" : "★")
        }
        ratingStars.text = ratingText
    }

    private func setVideoThumbs(with images: [UIImage]) {

        for subView in self.videosContainer.arrangedSubviews {
            self.videosContainer.removeArrangedSubview(subView)
        }

        for (index, thumb) in images.enumerated() {

            let thumbViewContainer = VideoThumbView()
            thumbViewContainer.imageView.image = thumb

            self.videosContainer.addArrangedSubview(thumbViewContainer)

            Cartography.constrain(thumbViewContainer.view, self.overviewLabel) {
                (imageContainer, label) in
                imageContainer.height == 190 //container video thumb size
                imageContainer.width == label.width
            }

            thumbViewContainer.view.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self._viewModel.didTapVideoThumb(at: index)
            })
            .disposed(by: self._disposeBag)
        }

    }

}
