//
//  HomeViewModelSpec.swift
//  Makeshift Netflix Tests
//
//  Created by Art Derkint on 12/10/21.
//

import Quick
import Nimble
import Apollo
@testable import Makeshift_Netflix

final class HomeViewModelSpec: QuickSpec {

  override func spec() {
    describe("Home view model") {
      context("When 3 sections available") {
        it("Returns 3 sections") {
          let sut = HomeViewModel()

          expect(sut.sections.count).to(equal(3))
          expect(sut.sections[0].title).to(equal("Movies: Top 5"))
          expect(sut.sections[1].title).to(equal("Browse by All"))
          expect(sut.sections[2].title).to(equal("Browse by Genre"))
        }
      }
      context("When top movies requested") {
        it("Has top movie objects") {
          let sut = HomeViewModel(network: TopMovieNetworkMock(movies: [TopMoviesQuery.Data.Movie(id: 1, title: "Movie 1", posterPath: nil)]))

          /// Quick/Nimble doesn't support async function testing yet https://github.com/Quick/Quick/issues/1084
          /// So we need to use workaround by using Task here
          Task(priority: .background, operation: { await sut.loadTopMovies() })

          expect(sut.topMovies.count).toEventually(equal(1))
        }
      }
      context("When requesting genres") {
        it("Has list of genres") {
          let sut = HomeViewModel(network: GenresNetworkMock(genres: ["Movie genre 1"]))

          Task(priority: .background, operation: { await sut.loadAllGenres() })

          expect(sut.allGenres.count).toEventually(equal(1))
        }
      }
    }
  }

}

final class TopMovieNetworkMock: NetworkProtocol {

  func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
    data as! Query.Data
  }

  private let data: TopMoviesQuery.Data
  init(movies: [TopMoviesQuery.Data.Movie]) {
    self.data = TopMoviesQuery.Data(movies: movies)
  }

}

final class GenresNetworkMock: NetworkProtocol {

  func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
    data as! Query.Data
  }

  private let data: AllGenresQuery.Data
  init(genres: [String]) {
    self.data = AllGenresQuery.Data(genres: genres)
  }
}
