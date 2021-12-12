//
//  HomeView.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject private var viewModel = HomeViewModel()

  @State private var selectedMovie: TopMoviesQuery.Data.Movie? = nil
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.sections) { section in
          switch section.index {
          case 0:
            topMoviesSection(title: section.title)
          case 1:
            NavigationLink(destination: MoviesView(genre: nil)) {
              Text(section.title)
                .padding(.top, 20)
                .padding(.bottom, 20)
                .accessibilityElement(children: .contain)
                .accessibility(identifier: "browse by all view")
            }
          case 2:
            genresSection(title: section.title)
          default:
            EmptyView()
          }
        }
      }
      .sheet(item: $selectedMovie, onDismiss: {
        selectedMovie = nil
      }, content: { movie in
        MovieDetailsView(id: movie.id)
      })
      .navigationTitle("Makeshift Netflix")
      .onAppear() {
        viewModel.loadContent()
      }
    }
    .alert(isPresented: $viewModel.errorToHandle.mappedToBool()) {
      Alert(title: Text("Error happened \(viewModel.errorToHandle?.localizedDescription ?? "")"),
            dismissButton: .cancel(
              Text("Retry"),
              action: {
                viewModel.loadContent()
              }))

    }
    .listStyle(PlainListStyle())
  }

  func topMoviesSection(title: String) -> some View {
    Section(header: Text(title)) {
      ScrollView(.horizontal) {
        LazyHGrid(rows: [GridItem(.adaptive(minimum: 100), spacing: 10)]) {
          ForEach(viewModel.topMovies) { movie in
            MoviePosterView(movie: movie)
              .onTapGesture {
                selectedMovie = movie
              }
          }
        }
      }
      .listRowInsets(EdgeInsets())
      .frame(height: 150)
    }
  }

  func genresSection(title: String) -> some View {
    Section(header: Text(title)) {
      ForEach(viewModel.allGenres, id: \.self) { genre in
        NavigationLink(destination: MoviesView(genre: genre)) { 
          Text(genre)
            .accessibilityElement(children: .contain)
            .accessibility(identifier: "genre view")
        }
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }

}

