import ComposableArchitecture
import Foundation
import Models

public struct TermsOfService: ReducerProtocol {
  public struct State: Equatable {
    var isToggleOn = false

    public init() {}
  }

  public enum Action: Equatable {
    case goToNextTapped
    case setToggleOn(Bool)
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .goToNextTapped:
        return .none

      case let .setToggleOn(isOn):
        state.isToggleOn = isOn
        return .none
      }
    }
  }
}
