import ComposableArchitecture
import Foundation
import Models

public struct PersonalInfo: ReducerProtocol {
  public struct State: Equatable {
    @BindingState public var firstName: String = ""
    @BindingState public var lastName: String = ""
    @BindingState public var phoneNumber: String = ""

    var enabled: Bool {
      !firstName.isEmpty && !lastName.isEmpty && !phoneNumber.isEmpty
    }

    public init() {}
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
