//
//  MoviesView.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/11/21.
//

import SwiftUI

struct MoviesView: View {

  @ObservedObject private var viewModel = MoviesViewModel()

  @State private var selectedMovie: MoviesQuery.Data.Movie? = nil

  @State private var searchText = ""

  private let title: String
  private let genre: String?
  init(genre: String?) {
    self.genre = genre
    title = genre ?? "All movies"
  }

  var body: some View {
    GeometryReader { geometry in
      if viewModel.allMovies.count == 0 {
        Text("No movies found...just like on real Netflix :)")
          .padding(.leading, 24)
          .padding(.trailing, 24)
      }
      ScrollView(.vertical) {
        let columns = [GridItem(.adaptive(minimum: geometry.size.width / 3, maximum: geometry.size.width / 2))]
        LazyVGrid(columns: columns) {
          ForEach(Array(zip(viewModel.allMovies.indices, viewModel.allMovies)), id: \.0) { index, movie in
            MoviePosterView(movie: movie)
              .onTapGesture {
                selectedMovie = movie
              }
              .frame(minHeight: geometry.size.height / 3)
              .onAppear {
                let isLastItem = index == viewModel.allMovies.count - 1
                if isLastItem {
                  viewModel.loadNextPage()
                }
              }
          }
        }
      }
      .sheet(item: $selectedMovie, onDismiss: {
        selectedMovie = nil
      }, content: { movie in
        MovieDetailsView(id: movie.id)
      })
      .navigationBarTitle(title, displayMode: .inline)
      .searchable(text: $searchText)
      .onChange(of: searchText) { newValue in
        viewModel.searchText = newValue
      }
      .alert(isPresented: $viewModel.errorToHandle.mappedToBool()) {
        Alert(title: Text("Error happened \(viewModel.errorToHandle?.localizedDescription ?? "")"),
              dismissButton: .cancel(
                Text("Retry"),
                action: {
                  viewModel.loadContent(genre: genre)
                }))
      }
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier("movies view")
    }
  }

}

struct MoviesView_Previews: PreviewProvider {
  static var previews: some View {
    MoviesView(genre: "Thriller")
  }
}
