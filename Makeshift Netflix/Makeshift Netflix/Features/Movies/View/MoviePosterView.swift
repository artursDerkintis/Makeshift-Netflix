//
//  MoviePosterView.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import SwiftUI
import URLImage

struct MoviePosterView: View {

  private let posterUrl: URL
  private let title: String
  
  init(movie: TopMoviesQuery.Data.Movie) {
    self.posterUrl = movie.posterUrl
    self.title = movie.title
  }
  
  init(movie: MoviesQuery.Data.Movie) {
    self.posterUrl = movie.posterUrl
    self.title = movie.title
  }

  var body: some View {
    ZStack(alignment: .bottom) {
      URLImage(posterUrl) { image in
        image
          .resizable()
          .frame(minWidth: 100, minHeight: 150)
          .aspectRatio(contentMode: .fit)
      }
      Rectangle()
        .foregroundColor(.clear)
        .background(
          LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8), .black]), startPoint: .center, endPoint: .bottom)
        )

      Text(title)
        .foregroundColor(.white)
        .shadow(color: .pink, radius: 1.0, x: 0.5, y: 0.1)
        .padding(.bottom, 10)
        .font(Font.caption)
        .frame(maxWidth: 100)
    }
    .accessibilityElement(children: .contain)
    .accessibilityIdentifier("movie poster view")
  }
}

struct MoviePosterView_Previews: PreviewProvider {
  static var previews: some View {
    MoviePosterView(movie: TopMoviesQuery.Data.Movie(id: 1, title: "Movie 1", posterPath: "https://image.tmdb.org/t/p/w300_and_h450_bestv2/7Haj9RQfymwoc9vFRnD1JZ3VOTb.jpg"))
      .previewLayout(PreviewLayout.sizeThatFits)
      .padding()
      .previewDisplayName("Default preview")
  }
}
