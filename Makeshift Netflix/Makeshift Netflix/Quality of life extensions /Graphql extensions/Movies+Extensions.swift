//
//  Movies+Extensions.swift
//  Makeshift Netflix
//
//  Created by Art Derkint on 12/11/21.
//

import Foundation

extension MoviesQuery.Data.Movie {
  var posterUrl: URL {
    URL(string: posterPath ?? "https://www.example.com") ?? URL(fileURLWithPath: "/")
  }
}

extension MoviesQuery.Data.Movie: Identifiable {}
