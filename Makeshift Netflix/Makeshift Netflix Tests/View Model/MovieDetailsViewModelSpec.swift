//
//  MovieDetailsViewModelSpec.swift
//  Makeshift Netflix Tests
//
//  Created by Art Derkint on 12/10/21.
//

import XCTest
import Quick
import Nimble
import Apollo
@testable import Makeshift_Netflix

final class MovieDetailsViewModelSpec: QuickSpec {

  override func spec() {
    describe("Movie details view model") {
      context("When movie details are available") {
        it("Has movie object") {
          let sut = MovieDetailsViewModel(network: MovieDetailsNetworkMock(movie: MovieQuery.Data.Movie(id: 0, title: "Movie 1", overview: "Movie overview", posterPath: nil, releaseDate: "June 2304", voteAverage: 4.55, voteCount: 100, runtime: 1234, cast: [MovieQuery.Data.Movie.Cast(profilePath: nil, name: "Art", character: "Art", order: 0)], director: MovieQuery.Data.Movie.Director(id: 0, name: "Jeeffff"))))

          sut.loadContent(id: 0)

          expect(sut.movieDetails).toEventuallyNot(beNil())
        }
      }
    }
  }

}

final class MovieDetailsNetworkMock: NetworkProtocol {

  func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
    data as! Query.Data
  }

  private let data: MovieQuery.Data
  init(movie: MovieQuery.Data.Movie) {
    self.data = MovieQuery.Data(movie: movie)
  }

}
