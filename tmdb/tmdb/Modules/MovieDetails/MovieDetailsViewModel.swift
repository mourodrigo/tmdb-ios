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
}

class MovieDetailsViewModel: BaseViewModel, MovieDetailsViewModelProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private let _disposeBag = DisposeBag()
    private weak var _coordinator: MovieDetailsCoordinatorProtocol?

    private let _movie: Movie
    private let _genre: Genre

    private let _api: APIRequest

    private let _posterImage =  BehaviorSubject<UIImage?>(value: nil)
    var posterImage: Observable<UIImage?> { return _posterImage.asObserver() }

    var title: String {
        return _movie.originalTitle ?? ""
    }

    var overview: String {
        return _movie.overview
    }

    var genre: String {
        return _genre.name
    }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: MovieDetailsCoordinatorProtocol, movie: Movie, genre: Genre, api: APIRequest) {
        _movie = movie
        _api = api
        _genre = genre
        _coordinator = coordinator
        super.init()
        setup()
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

    private func setup() {
        loadImage()

    }

    

}
