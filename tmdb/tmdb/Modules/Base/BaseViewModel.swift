//  BaseViewModel.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModelProtocol: class {
	var isLoading: Driver<Bool> { get }
}

class BaseViewModel {

	//************************************************
	// MARK: - Lifecycle
	//************************************************

	init() {
		print("🆕 ---> \(String(describing: type(of: self)))")
	}

	deinit {
		print("☠️ ---> \(String(describing: type(of: self)))")
	}

	//************************************************
	// MARK: - IsLoading
	//************************************************

	private let _isLoading = BehaviorRelay<Bool>(value: false) //TODO
	var isLoading: Driver<Bool> { return _isLoading.asDriver() }

	func setIsLoading(_ value: Bool) {
		_isLoading.accept(value)
	}
}
