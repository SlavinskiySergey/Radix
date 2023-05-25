import ComposableArchitecture
import CredentialsFeature
import NavigationTransitions
import PersonalInfoFeature
import PinFeature
import SwiftUI
import TermsOfServiceFeature

public struct LoggedOutView: View {
  let store: StoreOf<LoggedOut>
  @ObservedObject var viewStore: ViewStore<Void, LoggedOut.Action>

  public init(store: StoreOf<LoggedOut>) {
    self.store = store
    self.viewStore = ViewStore(self.store.stateless)
  }

  public var body: some View {
    NavigationStackStore(
      self.store.scope(
        state: \.path,
        action: LoggedOut.Action.path
      )
    ) {
      VStack(spacing: 32) {
        Text("Welcome!")

        Button("Proceed") {
          viewStore.send(.goToNextTapped)
        }
        .buttonStyle(.borderedProminent)
      }
    } destination: {
      switch $0 {
      case .credentials:
        CaseLet(
          state: /LoggedOut.Path.State.credentials,
          action: LoggedOut.Path.Action.credentials,
          then: CredentialsView.init(store:)
        )
      case .personalInfo:
        CaseLet(
          state: /LoggedOut.Path.State.personalInfo,
          action: LoggedOut.Path.Action.personalInfo,
          then: PersonalInfoView.init(store:)
        )
      case .pin:
        CaseLet(
          state: /LoggedOut.Path.State.pin,
          action: LoggedOut.Path.Action.pin,
          then: PinView.init(store:)
        )
      case .termsOfService:
        CaseLet(
          state: /LoggedOut.Path.State.termsOfService,
          action: LoggedOut.Path.Action.termsOfService,
          then: TermsOfServiceView.init(store:)
        )
      }
    }
    /// Animated transitions between screens 
    .navigationTransition(.slide(axis: .vertical))
  }
}

#if DEBUG
struct LoggedOutView_Previews: PreviewProvider {
  static var previews: some View {
    LoggedOutView(
      store: Store(
        initialState: LoggedOut.State(),
        reducer: LoggedOut()
      )
    )
  }
}
#endif
