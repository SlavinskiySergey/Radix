import ComposableArchitecture
import SwiftUI

public struct CredentialsView: View {
  let store: StoreOf<Credentials>
  @ObservedObject var viewStore: ViewStoreOf<Credentials>

  public init(store: StoreOf<Credentials>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }

  public var body: some View {
    VStack {
      Text("Credentials")

      TextField(
        "Email",
        text: viewStore.binding(\.$email)
      )
      .autocorrectionDisabled()

      SecureField(
        "Password",
        text: viewStore.binding(\.$password)
      )
      .autocorrectionDisabled()

      Button("Proceed") {
        viewStore.send(.goToNextTapped)
      }
      .buttonStyle(.borderedProminent)
      .disabled(!viewStore.enabled)
    }
    .textFieldStyle(.roundedBorder)
    .padding()
  }
}

#if DEBUG
struct CredentialsView_Previews: PreviewProvider {
  static var previews: some View {
    CredentialsView(
      store: Store(
        initialState: Credentials.State(),
        reducer: Credentials()
      )
    )
  }
}
#endif
