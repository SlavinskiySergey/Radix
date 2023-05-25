import ComposableArchitecture
import LoggedInFeature
import LoggedOutFeature
import Models
import UserDefaultsClient

public struct AppCore: Reducer {
  public enum State: Equatable {
    case launching
    case loggedIn(LoggedIn.State)
    case loggedOut(LoggedOut.State)

    public init() {
      self = .launching
    }
  }

  public enum Action: Equatable {
    case loggedIn(LoggedIn.Action)
    case loggedOut(LoggedOut.Action)
    case task
  }

  @Dependency(\.userDefaultsClient) var userDefaultsClient

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .loggedIn(.loggedOutTapped):
        userDefaultsClient.delete(modelType: User.self)
        state = .loggedOut(LoggedOut.State())
        return .none

      case let .loggedOut(.delegate(.save(user))):
        userDefaultsClient.create(model: user)
        state = .loggedIn(LoggedIn.State(user: user))
        return .none

      case .loggedOut:
        return .none

      case .task:
        if let user: User = userDefaultsClient.read() {
          state = .loggedIn(LoggedIn.State(user: user))
        } else {
          state = .loggedOut(LoggedOut.State())
        }
        return .none
      }
    }
    .ifCaseLet(/State.loggedIn, action: /Action.loggedIn) {
      LoggedIn()
    }
    .ifCaseLet(/State.loggedOut, action: /Action.loggedOut) {
      LoggedOut()
    }
  }
}
