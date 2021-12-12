//
//  MovieDetails+Extensions.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import Foundation

extension MovieQuery.Data.Movie {
  var posterUrl: URL {
    URL(string: posterPath ?? "https://www.example.com") ?? URL(fileURLWithPath: "/")
  }
}

extension MovieQuery.Data.Movie.Cast: Identifiable {
  public var id: Int { order }

  var imageUrl: URL {
    URL(string: profilePath ?? "https://www.example.com") ?? URL(fileURLWithPath: "/")
  }
}
