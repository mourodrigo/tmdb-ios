//  MovieDetailViewModelTests.swift
//  tmdbTests
import XCTest

@testable import tmdb

class MovieDetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAssertViewModelTexts() throws {

        let genreName = "Action"
        let title = "Dummy title"

        let aMovie = Movie(popularity: 50.0,
                            id: 234,
                            video: false,
                            voteCount: 300,
                            voteAverage: 5423/0,
                            title: title,
                            releaseDate: "2020-08-14",
                            originalLanguage: nil,
                            originalTitle: title,
                            genreIDS: nil,
                            backdropPath: nil,
                            adult: false,
                            overview: "A beauthiful story",
                            posterPath: "")

        let aGenre = Genre.init(id: 300, name: genreName)

        let dummmyCoordinator = MovieDetailsCoordinator(movie: aMovie, genre: aGenre, api: MOCKED_APIRequests_Success())

        let viewmodel = MovieDetailsViewModel(coordinator: dummmyCoordinator,
                                               movie: aMovie,
                                               genre: aGenre,
                                               api: MOCKED_APIRequests_Success())

        XCTAssert(genreName == viewmodel.genre, "Viewmodel genre is not correct in MovieDetailsViewModel")
        XCTAssert(title == viewmodel.title, "Viewmodel title is not correct in MovieDetailsViewModel")
    }

}
