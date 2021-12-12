//
//  MovieDetailsView.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import SwiftUI
import URLImage

struct MovieDetailsView: View {

  @ObservedObject private var viewModel = MovieDetailsViewModel()

  private let id: Int
  init(id: Int) {
    self.id = id
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Rectangle().foregroundColor(.black).ignoresSafeArea()
        if let movie = viewModel.movieDetails {
          URLImage(movie.posterUrl) { image in
            image
              .resizable()
              .scaledToFit()
          }
          Rectangle()
            .foregroundColor(.clear)
            .background(
              LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0.5), .clear,  .black]), startPoint: .top, endPoint: .bottom)
            )
          ScrollView {
            VStack(alignment: .leading, spacing: 24) {
              titleAndOverview(movie: movie)
              rating(movie: movie, viewWidth: geometry.size.width)
              director(movie: movie)
              cast(movie: movie)
            }
            .padding(.top, geometry.size.height * 0.6)
          }
        }
      }
      .ignoresSafeArea()
      .alert(isPresented: $viewModel.errorToHandle.mappedToBool()) {
        Alert(title: Text("Error happened \(viewModel.errorToHandle?.localizedDescription ?? "")"),
              dismissButton: .cancel(
                Text("Retry"),
                action: {
                  viewModel.loadContent(id: id)
                }))
      }
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier("movie details view")
    .onAppear() {
      viewModel.loadContent(id: id)
    }
  }

  private func titleAndOverview(movie: MovieQuery.Data.Movie) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(movie.title)
        .font(.title)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
      Text(movie.overview)
        .font(.subheadline)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
    }
    .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier("title and overview view")
  }

  private func director(movie: MovieQuery.Data.Movie) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Director")
        .font(.title3)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
      Text(movie.director.name)
        .font(.subheadline)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
    }
    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier("director view")
  }

  private func rating(movie: MovieQuery.Data.Movie, viewWidth: CGFloat) -> some View {

    VStack(alignment: .leading) {
      Text("\(String(format: "%.1f", movie.voteAverage)) out of 10 - \(movie.voteCount) rating(s)")
        .font(.title3)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))

      ZStack(alignment: .leading) {

        let ratio = movie.voteAverage / 10
        let maxWidth = viewWidth * 0.6
        let ratioWidth = maxWidth * CGFloat(ratio)

        Rectangle()
          .frame(width: maxWidth, height: 10, alignment: .leading)
          .foregroundColor(.white)
          .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
        Rectangle()
          .frame(width: ratioWidth, height: 8, alignment: .leading)
          .foregroundColor(.pink)
          .padding(.leading, 1)
      }.padding(.leading, 24)
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier("rating view")
  }

  private func cast(movie: MovieQuery.Data.Movie) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Cast")
        .font(.title3)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
      ScrollView(.horizontal) {
        LazyHGrid(rows: [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 10)]) {
          ForEach(movie.cast) { member in
            VStack(spacing: 0) {
              URLImage(member.imageUrl) { image in
                image
                  .resizable()
                  .scaledToFill()
                  .frame(width: 75, height: 75)
                  .clipShape(Circle())
                  .padding(.bottom, 12)
              }
              Text(member.name)
                .font(.subheadline)
                .foregroundColor(.white)
                .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
              Text("as \(member.character)")
                .font(.subheadline)
                .foregroundColor(.white)
                .shadow(color: .pink, radius: 3, x: 0.5, y: 0.2)
            }
          }
        }
      }
      .frame(height: 150)
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier("cast view")
  }
}

struct MovieDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    MovieDetailsView(id: 250734)
  }
}
