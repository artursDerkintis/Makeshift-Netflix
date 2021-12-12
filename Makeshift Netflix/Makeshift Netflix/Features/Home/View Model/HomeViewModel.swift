//
//  HomeViewModel.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {

  private let topMoviesLimit = 5

  private let network: NetworkProtocol
  init(network: NetworkProtocol = Network()) {
    self.network = network
  }

  @Published var topMovies: [TopMoviesQuery.Data.Movie] = []
  @Published var allGenres: [String] = []
  @Published var errorToHandle: Error? = nil

  private(set) var sections: [HomeSection] = [
    HomeSection(index: 0, title: "Movies: Top 5"),
    HomeSection(index: 1, title: "Browse by All"),
    HomeSection(index: 2, title: "Browse by Genre")
  ]

  func loadContent() {
    Task { [weak self] in
      await self?.loadTopMovies()
    }

    Task { [weak self] in
      await self?.loadAllGenres()
    }

  }

  func loadTopMovies() async {
    let query = TopMoviesQuery(limit: topMoviesLimit)
    do {
      guard let movies = try await network.fetch(query: query).movies?.compactMap({ $0 }) else {
        return
      }
      await setTopMovies(movies: movies)
    } catch {
      await setErrorToHandle(error: error)
    }
  }



  func loadAllGenres() async {
    let query = AllGenresQuery()
    do {
      let genres = try await network.fetch(query: query).genres
      await setAllGenres(genres: genres)
    } catch {
      await setErrorToHandle(error: error)
    }
  }
  
  @MainActor private func setTopMovies(movies: [TopMoviesQuery.Data.Movie]) {
    topMovies = movies
  }

  @MainActor private func setAllGenres(genres: [String]) {
    allGenres = genres
  }

  @MainActor private func setErrorToHandle(error: Error) {
    errorToHandle = error
  }

}
