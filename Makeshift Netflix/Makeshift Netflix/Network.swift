import Foundation
import Apollo

protocol NetworkProtocol {
  func fetch<Query: GraphQLQuery>(query: Query) async throws -> Query.Data
}

final class Network: NetworkProtocol {

  func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
    try await withCheckedThrowingContinuation({ [weak self] continuation in
      self?.apollo.fetch(query: query, resultHandler: { result in
        switch result {
        case .success(let graphQLResult):
          guard let data = graphQLResult.data else { return }
          continuation.resume(returning: data)
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      })
    })
  }

  static let shared = Network()
  private static let apiEndpoint = "Please contact project owner for this part of url :)/.netlify/functions/graphql"

  private lazy var apollo = ApolloClient(url: URL(string: Self.apiEndpoint)!)

}

