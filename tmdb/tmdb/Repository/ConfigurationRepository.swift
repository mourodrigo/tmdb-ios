//  ConfigurationRepository.swift
//  tmdb

import Foundation
import RxSwift

enum ConfigurationRepositoryStatus {
    case success(configuration: Configuration)
    case loading
    case error(error: Error)

    static func == (lhs: ConfigurationRepositoryStatus, rhs: ConfigurationRepositoryStatus) -> Bool {
        switch (lhs, rhs) {
        case let (.success(configuration: aaa),   .success(configuration: bbb)):
            return aaa.images.baseURL == bbb.images.baseURL //more checking can be added here
        case (.loading, .loading):
            return true
        case let (.error(error: errorA), .error(error: errorB)):
            return errorA.localizedDescription == errorB.localizedDescription
        default:
            return false
        }
    }
}


protocol ConfigurationRepositoryProtocol {
    var state: Observable<ConfigurationRepositoryStatus> { get }
    func fetch()
    func posterPath() -> String?
}

class ConfigurationRepository: ConfigurationRepositoryProtocol {

    //*************************************************
    // MARK: - Properties
    //*************************************************
    private let _api: APIRequest
    private let _state = BehaviorSubject<ConfigurationRepositoryStatus>(value: .loading)
    var state: Observable<ConfigurationRepositoryStatus> { return _state.asObserver() }

    //*************************************************
    // MARK: - Life Cycle
    //*************************************************

    init(api: APIRequest) {
        _api = api
        fetch()
    }

    func fetch() {
        _state.onNext(.loading)
        _api.get(url: TMDB.resourceURL.configuration.URLValue,
                onSuccess: { [weak self] (data) in
                    if let object = data.mapObject(Configuration.self) {
                        self?._state.onNext(.success(configuration: object))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))
        }) { [weak self] (error) in
            self?._state.onNext(.error(error:
                    CustomError.serverError(details: error.localizedDescription)))
        }
    }

    func posterPath() -> String? {
        switch try? _state.value() {
        case .success(let configuration):
            let base = configuration.images.baseURL

            //TODO: choose poster size depending on container size passed by param
            if let posterSize = configuration.images.posterSizes.first {
                return "\(base)\(posterSize)"
            }
            return nil

        default: return nil
        }

    }

}
