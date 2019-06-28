import Combine

/// A network transport is responsible for sending GraphQL operations to a server.
public protocol NetworkTransport {
  /// Send a GraphQL operation to a server and return a response.
  ///
  /// - Parameters:
  ///   - operation: The operation to send.
  ///   - fetchHTTPMethod: The HTTP Method to be used.
  ///   - completionHandler: A closure to call when a request completes.
  ///   - response: The response received from the server, or `nil` if an error occurred.
  ///   - error: An error that indicates why a request failed, or `nil` if the request was succesful.
  /// - Returns: An object that can be used to cancel an in progress request.
  func send<Operation>(operation: Operation, fetchHTTPMethod: FetchHTTPMethod, completionHandler: @escaping (_ response: GraphQLResponse<Operation>?, _ error: Error?) -> Void) -> Cancellable
  
  @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  func send<Operation>(operation: Operation) -> AnyPublisher<GraphQLResponse<Operation>, Error>
}
