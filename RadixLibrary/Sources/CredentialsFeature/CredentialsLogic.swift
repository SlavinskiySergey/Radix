import ComposableArchitecture
import Foundation
import Models

public struct Credentials: ReducerProtocol {
  public struct State: Equatable {
    @BindingState var email: String = ""
    @BindingState var password: String = ""

    public init() {}

    var enabled: Bool {
      !email.isEmpty && !password.isEmpty
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case goToNextTapped
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .goToNextTapped:
        return .none
      }
    }
  }
}
