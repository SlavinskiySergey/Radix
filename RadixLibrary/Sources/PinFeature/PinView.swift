import ComposableArchitecture
import SwiftUI

public struct PinView: View {
  let store: StoreOf<Pin>
  @ObservedObject var viewStore: ViewStoreOf<Pin>

  public init(store: StoreOf<Pin>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }

  public var body: some View {
    VStack {
      switch viewStore.useCase {
      case .new:
        Text("Setup PIN code")
      case .confirm:
        Text("Confirm PIN code")
      }

      SecureField(
        "PIN",
        text: viewStore.binding(\.$code)
      )
      .keyboardType(.phonePad)
      .autocorrectionDisabled()
      .textFieldStyle(.roundedBorder)

      Button("Proceed") {
        viewStore.send(.goToNextTapped)
      }
      .buttonStyle(.borderedProminent)
      .disabled(!viewStore.enabled)
    }
    .padding()
  }
}

#if DEBUG
struct PinView_Previews: PreviewProvider {
  static var previews: some View {
    PinView(
      store: Store(
        initialState: Pin.State(
          useCase: .confirm("456")
        ),
        reducer: Pin()
      )
    )
  }
}
#endif
