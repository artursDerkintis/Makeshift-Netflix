//
//  MovieDetailsViewModel.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {

  private let network: NetworkProtocol
  init(network: NetworkProtocol = Network.shared) {
    self.network = network
  }

  @Published var movieDetails: MovieQuery.Data.Movie?
  @Published var errorToHandle: Error? = nil

  func loadContent(id: Int) {
    Task { [weak self] in
      await self?.loadMovieDetails(id: id)
    }
  }

  private func loadMovieDetails(id: Int) async {
    let query = MovieQuery(id: id)

    do {
      guard let movie = try await network.fetch(query: query).movie else { return }
      await setMovieDetails(movie: movie)
    } catch {
      await setErrorToHandle(error: error)
    }
  }

  @MainActor private func setMovieDetails(movie: MovieQuery.Data.Movie) {
    movieDetails = movie
  }

  @MainActor private func setErrorToHandle(error: Error) {
    errorToHandle = error
  }

}
