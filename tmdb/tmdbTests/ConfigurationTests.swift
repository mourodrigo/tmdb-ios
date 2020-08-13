//  ConfigurationTests.swift
//  tmdbTests

import XCTest
import RxSwift
import RxTest

@testable import tmdb

class ConfigurationTests: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }


    func testExpectedConfigurationURL() throws {

        let repo = ConfigurationRepository(api: MOCKED_APIRequests_Success())

        let status = scheduler.createObserver(ConfigurationRepositoryStatus.self)

        repo.state.bind(to: status).disposed(by: disposeBag)

        scheduler.start()

        repo.fetch()

        let testConfig = Configuration(images: ImageConfiguration(baseURL: "http://image.tmdb.org/t/p/",
                                                                  secureBaseURL: "https://image.tmdb.org/t/p/",
                                                                  backdropSizes: [],
                                                                  logoSizes: [],
                                                                  posterSizes: [],
                                                                  profileSizes: [],
                                                                  stillSizes: []))


         //asserts the url values are correct

        let assertion = status.events.last!.value.element! == ConfigurationRepositoryStatus.success(configuration: testConfig)

        XCTAssert(assertion)

    }

}
