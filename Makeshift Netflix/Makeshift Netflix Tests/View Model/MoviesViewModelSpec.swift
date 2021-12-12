//
//  MoviesViewModel.swift
//  Makeshift Netflix Tests
//
//  Created by Art Derkint on 12/10/21.
//

import XCTest
import Quick
import Nimble
import Apollo
@testable import Makeshift_Netflix

final class MoviesViewModelSpec: QuickSpec {

  override func spec() {
    describe("Movies view model") {
      context("When requesting movies for genre") {
        it("Has movie object and genre was passed to network layer") {
          let network = MoviesNetworkMock(movies: [MoviesQuery.Data.Movie(id: 0, title: "Movie 0", posterPath: nil)])
          let sut = MoviesViewModel(network: network)

          sut.loadContent(genre: "Movie genre")

          expect(sut.allMovies.count).toEventually(equal(1))
          expect(network.genre).toEventually(equal("Movie genre"))
        }
      }
      context("When requesting next page") {
        it("Has additional movie object") {
          let network = MoviesNetworkMock(movies: [MoviesQuery.Data.Movie(id: 0, title: "Movie 0", posterPath: nil)])
          let sut = MoviesViewModel(network: network)


          sut.loadContent(genre: nil)

          expect(sut.allMovies.count).toEventually(equal(1))

          network.data = MoviesQuery.Data(movies: [MoviesQuery.Data.Movie(id: 1, title: "Movie 1", posterPath: nil)])

          sut.loadNextPage()

          expect(sut.allMovies.count).toEventually(equal(2))
          expect(sut.allMovies[0].id).toEventually(equal(0))
          expect(sut.allMovies[1].id).toEventually(equal(1))
          expect(sut.currentOffset).toEventually(equal(20))

        }
      }
      context("When searching within Genre") {
        it("Has movie found and network receiving correct values") {
          let network = MoviesNetworkMock(movies: [MoviesQuery.Data.Movie(id: 0, title: "Movie 0", posterPath: nil)])
          let sut = MoviesViewModel(network: network)


          sut.loadContent(genre: "Genre")

          expect(sut.allMovies.count).toEventually(equal(1))

          network.data = MoviesQuery.Data(movies: [MoviesQuery.Data.Movie(id: 1, title: "Movie 5", posterPath: nil)])

          sut.searchText = "Movie"

          // Wait for internal typing debounce hence extra second of timeout here
          expect(sut.allMovies.first?.id).toEventually(equal(1), timeout: .seconds(2))
          expect(sut.allMovies.count).toEventually(equal(1), timeout: .seconds(2))
          expect(network.genre).toEventually(equal("Genre"))
          expect(network.searchText).toEventually(equal("Movie"))

        }
      }
    }
  }
}

final class MoviesNetworkMock: NetworkProtocol {
  func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
    genre = (query as! MoviesQuery).genre ?? ""
    searchText = (query as! MoviesQuery).search ?? ""
    return data as! Query.Data
  }

  var searchText = ""
  var genre = ""

  var data: MoviesQuery.Data
  init(movies: [MoviesQuery.Data.Movie]) {
    self.data = MoviesQuery.Data(movies: movies)
  }
}

