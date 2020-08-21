//  MovieDetailsViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailsViewModelProtocol: BaseViewModelProtocol {
    var posterImage: Observable<UIImage?> { get }
    var title: String { get }
    var genre: String { get }
    var overview: String { get }
    var rating: Int { get }
    var releaseDate: String? { get }
    var popularity: String { get }
    var watchNowURL: Driver<URL?> { get }
    var homePageURL: Driver<URL?> { get }
    var taglineText: Driver<String?> { get }
    var videoThumbs: Driver<[UIImage]> { get }
    func didTapHomePageButton()
    func didTapWatchButton()
    func didTapVideoThumb(at index: Int)
}

class MovieDetailsViewModel: BaseViewModel, MovieDetailsViewModelProtocol {

    //************************************************
    // MARK: - Private Properties
    //************************************************
    private let _api: APIRequest
    private let _detailsRepository: MovieDetailsRepository?
    private let _videoRepository: VideoRepository?
    private weak var _coordinator: MovieDetailsCoordinatorProtocol?
    private let _disposeBag = DisposeBag()

    private let _movie: Movie
    private let _genre: Genre

    private let _posterImage =  BehaviorSubject<UIImage?>(value: nil)
    private let _watchNowURL = BehaviorSubject<URL?>(value: nil)
    private let _homePageURL =  BehaviorSubject<URL?>(value: nil)
    private let _taglineText =  BehaviorSubject<String?>(value: nil)
    private let _videos =  BehaviorSubject<[Video]>(value: [Video]())
    private let _videosThumbs =  BehaviorSubject<[UIImage]>(value: [UIImage]())

    //************************************************
    // MARK: - Public Properties
    //************************************************

    var posterImage: Observable<UIImage?> { return _posterImage.asObserver() }

    var title: String {
        return _movie.title ?? ""
    }

    var overview: String {
        return _movie.overview
    }

    var genre: String {
        return _genre.name
    }

    var rating: Int {
        return Int(_movie.voteAverage ?? 0)
    }

    var popularity: String {
        return "♥︎ \(_movie.popularity ?? 0)"
    }

    var watchNowURL: Driver<URL?> {
        return _watchNowURL.asDriver(onErrorJustReturn: nil)
    }

    var homePageURL: Driver<URL?> {
        return _homePageURL.asDriver(onErrorJustReturn: nil)
    }

    var taglineText: Driver<String?> {
        return _taglineText.asDriver(onErrorJustReturn: nil)
    }

    var videoThumbs: Driver<[UIImage]> {
        return _videosThumbs.asDriver(onErrorJustReturn: [UIImage]())
    }

    var releaseDate: String? {
        //reformatting date
        //todo move to Movie data encoding
        if let releaseDate = _movie.releaseDate {

            let isoDate = "\(releaseDate)T00:00:00+0000"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            guard   let date = dateFormatter.date(from:isoDate)
                    else { return nil }

            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "dd-MM-yyyy"
            return "Lançamento: " + newFormatter.string(from: date)
        }
        return nil
    }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: MovieDetailsCoordinatorProtocol, movie: Movie, genre: Genre, api: APIRequest = AFRequest()) {
        _movie = movie
        _api = api
        _genre = genre
        _coordinator = coordinator
        _detailsRepository = MovieDetailsRepository(movie: movie, api: api)
        _videoRepository = VideoRepository(movie: movie, api: api)
        super.init()
        setup()
    }

    //*************************************************
    // MARK: - Binding vars & UI
    //*************************************************

    private func setup() {
        loadImage()
        fetchDetails()
        fetchVideos()
    }

    private func fetchDetails() {
        _detailsRepository?.state.bind(onNext: { [weak self] (status) in
            switch status {
            case .success(let details):
                self?.setupWatchButton(value: details.homepage)
                self?._taglineText.onNext(details.tagline)

            case .loading: break //do nothing for now
            case .error(error: let error):
                print("Error on \(String.init(describing: self)) while fetching _detailsRepository \n \(error.localizedDescription)")
            }
        }).disposed(by: _disposeBag)
    }

    private func fetchVideos() {
        _videoRepository?.state.bind(onNext: { [weak self] (status) in
            switch status {
            case .success(let content):
                self?.handleFetchedVideos(for: content.results)

            case .loading: break //do nothing for now
            case .error(error: let error):
                print("Error on \(String.init(describing: self)) while fetching _videoRepository \n \(error.localizedDescription)")
            }
        }).disposed(by: _disposeBag)
    }

    private func handleFetchedVideos(for videos: [Video]) {

        DispatchQueue.global().async {
            let imageRepo = SharedLocator.shared.imageRepository

            var videosHavingThumb = [Video]()
            var videoThumbs = [UIImage]()

            for video in videos {
                let semaphore = DispatchSemaphore(value: 0)
                if let url = video.thumbURL {
                    imageRepo.getImage(for: url,
                                       onSuccess: { (image, _) in
                                        videosHavingThumb.append(video)
                                        videoThumbs.append(image)
                                        semaphore.signal()
                    }) { (_ ) in
                        semaphore.signal()
                    }
                    semaphore.wait()
                }
            }

            self._videos.onNext(videosHavingThumb)
            self._videosThumbs.onNext(videoThumbs)
        }

    }

    private func setupWatchButton(value: String?) {
        guard   let value = value,
                let url = URL(string: value)
            else {
                _watchNowURL.onNext(nil)
                _homePageURL.onNext(nil)
                return
            }

        if value.contains("netflix") {
            _watchNowURL.onNext(url)
            return
        }

        _homePageURL.onNext(url)
    }


    private func loadImage() {
        let imageRepository = SharedLocator.shared.imageRepository

        guard   let posterPath = SharedLocator.shared.configurationRepository.posterPath(),
                let url = URL(string: "\(posterPath)/\(_movie.posterPath)")
                else { return }

        imageRepository.getImage(for: url, onSuccess: { [weak self] (image, resolvedURL) in
            self?._posterImage.onNext(image)
        }) { (error) in
            print("Could not find image at \(url) on \(String.init(describing: self))")
        }
    }

    //*************************************************
    // MARK: - Handls Actions
    //*************************************************

    func didTapHomePageButton() {
        if let url = try? _homePageURL.value() {
            UIApplication.shared.open(url)
        }
    }

    func didTapWatchButton() {
        if let url = try? _watchNowURL.value() {
            UIApplication.shared.open(url)
        }
    }

    func didTapVideoThumb(at index: Int) {
        if  let video = try? _videos.value()[index],
            let url = video.videoURL {
            UIApplication.shared.open(url)
        }
    }

}
