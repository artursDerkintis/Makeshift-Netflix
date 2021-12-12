// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class MovieQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Movie($id: Int!) {
      movie(id: $id) {
        __typename
        id
        title
        overview
        posterPath
        releaseDate
        voteAverage
        voteCount
        runtime
        cast {
          __typename
          profilePath
          name
          character
          order
        }
        director {
          __typename
          id
          name
        }
      }
    }
    """

  public let operationName: String = "Movie"

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("movie", arguments: ["id": GraphQLVariable("id")], type: .object(Movie.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(movie: Movie? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "movie": movie.flatMap { (value: Movie) -> ResultMap in value.resultMap }])
    }

    public var movie: Movie? {
      get {
        return (resultMap["movie"] as? ResultMap).flatMap { Movie(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "movie")
      }
    }

    public struct Movie: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Movie"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("overview", type: .nonNull(.scalar(String.self))),
          GraphQLField("posterPath", type: .scalar(String.self)),
          GraphQLField("releaseDate", type: .nonNull(.scalar(String.self))),
          GraphQLField("voteAverage", type: .nonNull(.scalar(Double.self))),
          GraphQLField("voteCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("runtime", type: .nonNull(.scalar(Int.self))),
          GraphQLField("cast", type: .nonNull(.list(.nonNull(.object(Cast.selections))))),
          GraphQLField("director", type: .nonNull(.object(Director.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, title: String, overview: String, posterPath: String? = nil, releaseDate: String, voteAverage: Double, voteCount: Int, runtime: Int, cast: [Cast], director: Director) {
        self.init(unsafeResultMap: ["__typename": "Movie", "id": id, "title": title, "overview": overview, "posterPath": posterPath, "releaseDate": releaseDate, "voteAverage": voteAverage, "voteCount": voteCount, "runtime": runtime, "cast": cast.map { (value: Cast) -> ResultMap in value.resultMap }, "director": director.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var overview: String {
        get {
          return resultMap["overview"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "overview")
        }
      }

      public var posterPath: String? {
        get {
          return resultMap["posterPath"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "posterPath")
        }
      }

      public var releaseDate: String {
        get {
          return resultMap["releaseDate"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "releaseDate")
        }
      }

      public var voteAverage: Double {
        get {
          return resultMap["voteAverage"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "voteAverage")
        }
      }

      public var voteCount: Int {
        get {
          return resultMap["voteCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "voteCount")
        }
      }

      public var runtime: Int {
        get {
          return resultMap["runtime"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "runtime")
        }
      }

      public var cast: [Cast] {
        get {
          return (resultMap["cast"] as! [ResultMap]).map { (value: ResultMap) -> Cast in Cast(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Cast) -> ResultMap in value.resultMap }, forKey: "cast")
        }
      }

      public var director: Director {
        get {
          return Director(unsafeResultMap: resultMap["director"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "director")
        }
      }

      public struct Cast: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Cast"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profilePath", type: .scalar(String.self)),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("character", type: .nonNull(.scalar(String.self))),
            GraphQLField("order", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(profilePath: String? = nil, name: String, character: String, order: Int) {
          self.init(unsafeResultMap: ["__typename": "Cast", "profilePath": profilePath, "name": name, "character": character, "order": order])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var profilePath: String? {
          get {
            return resultMap["profilePath"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profilePath")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var character: String {
          get {
            return resultMap["character"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "character")
          }
        }

        public var order: Int {
          get {
            return resultMap["order"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "order")
          }
        }
      }

      public struct Director: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Director"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String) {
          self.init(unsafeResultMap: ["__typename": "Director", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}
