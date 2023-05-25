import ComposableArchitecture
import LoggedInFeature
import LoggedOutFeature
import SwiftUI

public struct AppCoreView: View {
  let store: StoreOf<AppCore>
  @ObservedObject var viewStore: ViewStoreOf<AppCore>

  public init(store: StoreOf<AppCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }

  public var body: some View {
    SwitchStore(self.store) { state in
      switch state {
      case .launching:
        EmptyView()

      case .loggedIn:
        CaseLet(/AppCore.State.loggedIn, action: AppCore.Action.loggedIn) { store in
          LoggedInView(store: store)
        }
      case .loggedOut:
        CaseLet(/AppCore.State.loggedOut, action: AppCore.Action.loggedOut) { store in
          LoggedOutView(store: store)
        }
      }
    }
    .task {
      await viewStore.send(.task).finish()
    }
  }
}
