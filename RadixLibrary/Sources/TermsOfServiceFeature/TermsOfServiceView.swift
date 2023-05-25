import ComposableArchitecture
import SwiftUI

public struct TermsOfServiceView: View {
  let store: StoreOf<TermsOfService>
  @ObservedObject var viewStore: ViewStoreOf<TermsOfService>

  public init(store: StoreOf<TermsOfService>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }

  public var body: some View {
    VStack(spacing: 32) {
      Toggle(isOn: viewStore
        .binding(
          get: \.isToggleOn,
          send: TermsOfService.Action.setToggleOn
        )
      ) {
        Text("TermsOfService")
      }
      .toggleStyle(iOSCheckboxToggleStyle())
      .padding([.leading, .trailing], 64)

      Button("Proceed") {
        viewStore.send(.goToNextTapped)
      }
      .buttonStyle(.borderedProminent)
      .disabled(!viewStore.isToggleOn)
    }
  }
}

#if DEBUG
struct TermsOfServiceView_Previews: PreviewProvider {
  static var previews: some View {
    TermsOfServiceView(
      store: Store(
        initialState: TermsOfService.State(),
        reducer: TermsOfService()
      )
    )
  }
}
#endif
