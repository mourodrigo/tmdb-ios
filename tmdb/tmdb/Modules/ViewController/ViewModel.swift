//  ViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol: BaseViewModelProtocol {

}

class ViewModel: BaseViewModel, ViewModelProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private let _disposeBag = DisposeBag()

    private weak var _coordinator: CoordinatorProtocol?

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init(coordinator: CoordinatorProtocol) {
        _coordinator = coordinator
        super.init()
    }

    //************************************************
    // MARK: - Handle Actions
    //************************************************

}
