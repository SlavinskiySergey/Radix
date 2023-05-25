import ComposableArchitecture
import Foundation
import Models

public struct Pin: ReducerProtocol {
  public enum UseCase: Equatable {
    case new
    case confirm(String)
  }

  public struct State: Equatable {
    public let useCase: UseCase
    @BindingState var code: String = ""

    var enabled: Bool {
      switch self.useCase {
      case .new:
        return !code.isEmpty

      case let .confirm(pinCode):
        return self.code == pinCode
      }
    }

    public init(useCase: UseCase) {
      self.useCase = useCase
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case delegate(Delegate)
    case goToNextTapped
  }

  public enum Delegate: Equatable {
    case setup(pinCode: String)
    case confirm
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .delegate:
        return .none

      case .goToNextTapped:
        switch state.useCase {
        case .new:
          return .send(.delegate(.setup(pinCode: state.code)))

        case .confirm:
          return .send(.delegate(.confirm))
        }
      }
    }
  }
}
