//
//  Elements.swift
//  Makeshift Netflix UITests
//
//  Created by Art Derkint on 12/11/21.
//

import XCTest

struct Elements {

  static let timeout: TimeInterval = 10

  static var firstMoviePosterView: XCUIElement {
    let element = XCUIApplication().otherElements["movie poster view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var movieDetailsView: XCUIElement {
    let element = XCUIApplication().otherElements["movie details view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var castView: XCUIElement {
    let element = XCUIApplication().otherElements["cast view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var directorView: XCUIElement {
    let element = XCUIApplication().otherElements["director view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var ratingView: XCUIElement {
    let element = XCUIApplication().otherElements["rating view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var titleAndOverviewView: XCUIElement {
    let element = XCUIApplication().otherElements["title and overview view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var genreView: XCUIElement {
    let element = XCUIApplication().otherElements["genre view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var browseByAllView: XCUIElement {
    let element = XCUIApplication().otherElements["browse by all view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var moviesView: XCUIElement {
    let element = XCUIApplication().scrollViews["movies view"].firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var noMoviesFoundText: XCUIElement {
    let element = XCUIApplication().staticTexts.containing(NSPredicate(format: "label CONTAINS 'No movies found'")).firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  static var searchField: XCUIElement {
    let element = XCUIApplication().searchFields.firstMatch
    _ = element.waitForExistence(timeout: timeout)
    return element
  }

  
}
