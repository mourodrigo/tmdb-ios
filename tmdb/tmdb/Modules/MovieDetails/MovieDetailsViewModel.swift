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
        return "👍 \(_movie.popularity ?? 0) likes"
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
