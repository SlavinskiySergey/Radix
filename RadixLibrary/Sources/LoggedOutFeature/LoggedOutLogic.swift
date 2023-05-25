import ComposableArchitecture
import CredentialsFeature
import Foundation
import Models
import PersonalInfoFeature
import PinFeature
import TermsOfServiceFeature

public struct LoggedOut: ReducerProtocol {
  public struct State: Equatable {
    var path = StackState<Path.State>()
    var user: User?
    public init() {}
  }

  public enum Action: Equatable {
    case delegate(Delegate)
    case goToNextTapped
    case path(StackAction<Path.State, Path.Action>)
  }

  public enum Delegate: Equatable {
    case save(User)
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .goToNextTapped:
        state.path.append(.termsOfService(TermsOfService.State()))
        return .none

      case .path(.element(_, .credentials(.goToNextTapped))):
        state.path.append(.personalInfo(PersonalInfo.State()))
        return .none

      case let .path(.element(id, .personalInfo(.goToNextTapped))):
        guard case let .some(.personalInfo(personalInfoState)) = state.path[id: id]
        else { return .none }
        state.user = User(
          firstName: personalInfoState.firstName,
          lastName: personalInfoState.lastName,
          phoneNumber: personalInfoState.phoneNumber
        )

        state.path.append(.pin(Pin.State(useCase: .new)))
        return .none

      case .path(.element(_, .pin(.delegate(.confirm)))):
        guard let user = state.user
        else { return .none }
        return .send(.delegate(.save(user)))

      case let .path(.element(_, .pin(.delegate(.setup(pinCode))))):
        state.path.append(.pin(Pin.State(useCase: .confirm(pinCode))))
        return .none

      case .path(.element(_, .termsOfService(.goToNextTapped))):
        state.path.append(.credentials(Credentials.State()))
        return .none

      case let .path(.popFrom(id)):
        state.path.pop(from: id)
        return .none

      case .path:
        return .none
      }
    }
    .forEach(\.path, action: /Action.path) {
      Path()
    }
  }

  public struct Path: Reducer {
    public enum State: Equatable {
      case credentials(Credentials.State)
      case personalInfo(PersonalInfo.State)
      case pin(Pin.State)
      case termsOfService(TermsOfService.State)
    }

    public enum Action: Equatable {
      case credentials(Credentials.Action)
      case personalInfo(PersonalInfo.Action)
      case pin(Pin.Action)
      case termsOfService(TermsOfService.Action)
    }

    public var body: some Reducer<State, Action> {
      Scope(state: /State.credentials, action: /Action.credentials) {
        Credentials()
      }
      Scope(state: /State.personalInfo, action: /Action.personalInfo) {
        PersonalInfo()
      }
      Scope(state: /State.pin, action: /Action.pin) {
        Pin()
      }
      Scope(state: /State.termsOfService, action: /Action.termsOfService) {
        TermsOfService()
      }
    }
  }
}
