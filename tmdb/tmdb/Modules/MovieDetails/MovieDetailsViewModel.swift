//  MovieDetailsViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailsViewModelProtocol: BaseViewModelProtocol {

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

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: MovieDetailsCoordinatorProtocol, movie: Movie, genre: Genre, api: APIRequest) {
        _movie = movie
        _api = api
        _genre = genre
        _coordinator = coordinator
        super.init()
    }

}
