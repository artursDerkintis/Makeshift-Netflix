//
//  MakeshiftNetflixTests.swift
//  Makeshift Netflix UITests
//
//  Created by Art Derkint on 12/11/21.
//

import XCTest

// NOTE: in "real" app I would break these up in dedicated files, but since we only have 3 screens I decided to keep them in one file
final class MakeshiftNetflixTests: XCTestCase {

  override func setUp() {
    super.setUp()
    XCUIApplication().launch()
  }

  func test_user_can_open_movie_from_top_movies_section_in_home_view() {
    Elements.firstMoviePosterView.tap()
    XCTAssertEqual(Elements.movieDetailsView.exists, true)
  }

  func test_user_can_see_the_cast_in_movie_details() {
    Elements.firstMoviePosterView.tap()
    XCTAssertEqual(Elements.movieDetailsView.exists, true)

    Elements.movieDetailsView.swipeUp(velocity: .fast)

    XCTAssertEqual(Elements.castView.isHittable, true)
  }

  func test_user_can_see_the_director_in_movie_details() {
    Elements.firstMoviePosterView.tap()
    XCTAssertEqual(Elements.movieDetailsView.exists, true)

    Elements.movieDetailsView.swipeUp(velocity: .fast)

    XCTAssertEqual(Elements.directorView.isHittable, true)
  }

  func test_user_can_see_the_title_and_overview_in_movie_details() {
    Elements.firstMoviePosterView.tap()
    XCTAssertEqual(Elements.movieDetailsView.exists, true)

    XCTAssertEqual(Elements.titleAndOverviewView.isHittable, true)
  }

  func test_user_can_see_the_rating_in_movie_details() {
    Elements.firstMoviePosterView.tap()
    XCTAssertEqual(Elements.movieDetailsView.exists, true)

    Elements.movieDetailsView.swipeUp(velocity: .fast)

    XCTAssertEqual(Elements.ratingView.isHittable, true)
  }

  func test_user_can_open_browse_by_genre_section_and_see_at_least_one_movie_poster() {

    Elements.genreView.tap()

    XCTAssertEqual(Elements.moviesView.isHittable, true)
    XCTAssertEqual(Elements.firstMoviePosterView.isHittable, true)
  }

  func test_user_can_search_for_text_we_know_exists_in_our_db_and_find_at_least_one_movie() {
    Elements.browseByAllView.tap()

    Elements.moviesView.swipeDown()

    Elements.searchField.tap()
    Elements.searchField.typeText("Far from home")

    XCTAssertEqual(Elements.firstMoviePosterView.exists, true)
    XCTAssertEqual(Elements.noMoviesFoundText.exists, false)
  }

  func test_user_can_search_for_text_we_know_does_not_exist_in_our_db_and_find_nothing() {
    Elements.browseByAllView.tap()

    Elements.moviesView.swipeDown()

    Elements.searchField.tap()
    Elements.searchField.typeText("THIS IS NOT A MOVIE NAME OR SEARCHABLE TERM")

    XCTAssertEqual(Elements.firstMoviePosterView.exists, false)
    XCTAssertEqual(Elements.noMoviesFoundText.isHittable, true)
  }

  func test_user_open_movie_details_from_browse_by_all_list_of_movies() {
    Elements.browseByAllView.tap()

    Elements.firstMoviePosterView.tap()

    XCTAssertEqual(Elements.movieDetailsView.exists, true)
  }

  func test_user_open_movie_details_from_genre_list_of_movies() {
    Elements.genreView.tap()

    Elements.firstMoviePosterView.tap()

    XCTAssertEqual(Elements.movieDetailsView.exists, true)
  }
  
}
