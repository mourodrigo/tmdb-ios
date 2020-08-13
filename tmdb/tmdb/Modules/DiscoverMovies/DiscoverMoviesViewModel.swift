//
//  DiscoverMoviesViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

protocol DiscoverMoviesViewModelProtocol: BaseViewModelProtocol {

}

class DiscoverMoviesViewModel: BaseViewModel, DiscoverMoviesViewModelProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private let _disposeBag = DisposeBag()

    private weak var _coordinator: DiscoverMoviesCoordinatorProtocol?

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: DiscoverMoviesCoordinatorProtocol) {
        _coordinator = coordinator
        super.init()
    }

    //************************************************
    // MARK: - Handle Actions
    //************************************************

}
