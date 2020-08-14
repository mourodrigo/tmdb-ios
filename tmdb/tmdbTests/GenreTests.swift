//  GenreTests.swift
//  tmdbTests

import XCTest
import RxSwift
import RxTest

@testable import tmdb

class GenreTests: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    func testSuccessGenreMockedRequest() throws {

        let repo = GenreRepository(api: MOCKED_APIRequests_Success())

        let status = scheduler.createObserver(GenreRepositoryStatus.self)

        repo.state.bind(to: status).disposed(by: disposeBag)

        scheduler.start()

        let testGenres = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"),
        Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 51, name: "Family"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"),
        Genre(id: 02, name: "Music"),
        Genre(id: 48, name: "Mystery"),
        Genre(id: 49, name: "Romance"),
        Genre(id: 78, name: "Science Fiction"),
        Genre(id: 70, name: "T Movie"),
        Genre(id: 53, name: "Thriller"),
        Genre(id: 52, name: "War"),
        Genre(id: 37, name: "Western")
        ]

        scheduler.start()

        // This int index below represents RX Virtual Time for Events
        // 0 (initial state), 1 (loading on fetch call), 2 (result)

        let loading = status.events[0].value.element == GenreRepositoryStatus.loading
        XCTAssert(loading)

        repo.fetch()

        let success = status.events[2].value.element == GenreRepositoryStatus.success(genres: testGenres)
        XCTAssert(success)

    }

    func testUnexpectedSizeGenreMockedRequest() throws {

           let repo = GenreRepository(api: MOCKED_APIRequests_Success())

           let status = scheduler.createObserver(GenreRepositoryStatus.self)

           repo.state.bind(to: status).disposed(by: disposeBag)

           scheduler.start()

           let testGenres = [
           Genre(id: 28, name: "Action"),
           Genre(id: 12, name: "Adventure")
           ]

           scheduler.start()

           repo.fetch()

            //asserts the values will be different from expected

            let assertion = status.events.last!.value.element != GenreRepositoryStatus.success(genres: testGenres)

        XCTAssert(assertion)

       }

}
