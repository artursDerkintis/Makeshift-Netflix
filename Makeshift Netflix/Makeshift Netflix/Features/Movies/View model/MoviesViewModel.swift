//
//  MoviesViewModel.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
  private var subscription = Set<AnyCancellable>()

  private let limit = 10
  private(set) var currentOffset = 0

  private var genre: String?
  @Published var searchText: String = ""

  @Published var allMovies: [MoviesQuery.Data.Movie] = []
  @Published var errorToHandle: Error? = nil

  private let network: NetworkProtocol
  init(network: NetworkProtocol = Network.shared) {
    self.network = network
    observeSearchText()
  }

  private func observeSearchText() {
    $searchText
      .removeDuplicates()
      .debounce(for: 1.0, scheduler: DispatchQueue.main)
      .sink { [weak self] searchText in
        self?.searchForMovie(text: searchText)
      }
      .store(in: &subscription)
  }

  deinit {
    subscription.removeAll()
  }

  func loadNextPage() {
    Task {
      await loadMovies()
    }
  }

  func loadContent(genre: String? = nil) {
    self.genre = genre
    searchText = ""
    currentOffset = 0
    allMovies = []
    Task {
      await loadMovies()
    }
  }
  
  private func searchForMovie(text: String) {
    allMovies = []
    currentOffset = 0
    Task {
      await loadMovies()
    }
  }

  private func loadMovies() async {
    let query = MoviesQuery(limit: limit, offset: currentOffset, genre: genre, search: searchText)

    do {
      guard let movies = try await network.fetch(query: query).movies?.compactMap({ $0 }) else { return }
      await setMovies(movies: movies)
    } catch {
      await setErrorToHandle(error: error)
    }
  }

  @MainActor private func setMovies(movies: [MoviesQuery.Data.Movie]) {
    allMovies += movies
    currentOffset += limit
  }

  @MainActor private func setErrorToHandle(error: Error) {
    errorToHandle = error
  }

}
