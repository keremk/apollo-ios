import Apollo
import Dispatch
import Combine

public final class MockNetworkTransport: NetworkTransport {
  let body: JSONObject

  public init(body: JSONObject) {
    self.body = body
  }

  public func send<Operation>(operation: Operation, fetchHTTPMethod: FetchHTTPMethod, completionHandler: @escaping (_ response: GraphQLResponse<Operation>?, _ error: Error?) -> Void) -> Apollo.Cancellable {
    DispatchQueue.global(qos: .default).async {
      completionHandler(GraphQLResponse(operation: operation, body: self.body), nil)
    }
    return MockTask()
  }
  
  @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  public func send<Operation: GraphQLOperation>(operation: Operation) -> AnyPublisher<GraphQLResponse<Operation>, Error>  {
    let response = GraphQLResponse(operation: operation, body: self.body)
    return Publishers.Once(response).eraseToAnyPublisher()
  }
}

private final class MockTask: Apollo.Cancellable {
  func cancel() {
  }
}
