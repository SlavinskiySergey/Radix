import ComposableArchitecture
import Foundation
import Models

public struct LoggedIn: ReducerProtocol {
  public struct State: Equatable {
    public let user: User

    public init(user: User) {
      self.user = user
    }
  }

  public enum Action: Equatable {
    case loggedOutTapped
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .loggedOutTapped:
        return .none
      }
    }
  }
}
