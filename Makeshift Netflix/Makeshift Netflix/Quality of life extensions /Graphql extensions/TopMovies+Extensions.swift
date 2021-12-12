//
//  TopMoviesDataMovie+extension.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/10/21.
//

import Foundation

extension TopMoviesQuery.Data.Movie {
  var posterUrl: URL {
    URL(string: posterPath ?? "https://www.example.com") ?? URL(fileURLWithPath: "/")
  }
}

extension TopMoviesQuery.Data.Movie: Identifiable {}
