//  MoviesListViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

protocol MoviesListCollectionViewModelProtocol: BaseViewModelProtocol {

}

class MoviesListCollectionViewModel: BaseViewModel, MoviesListCollectionViewModelProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private let _disposeBag = DisposeBag()

    private weak var _coordinator: MoviesListCollectionCoordinatorProtocol?

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: MoviesListCollectionCoordinatorProtocol) {
        _coordinator = coordinator
        super.init()
    }

    //************************************************
    // MARK: - Handle Actions
    //************************************************

}
