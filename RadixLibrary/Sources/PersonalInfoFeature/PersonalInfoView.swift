import ComposableArchitecture
import SwiftUI

public struct PersonalInfoView: View {
  let store: StoreOf<PersonalInfo>
  @ObservedObject var viewStore: ViewStoreOf<PersonalInfo>

  public init(store: StoreOf<PersonalInfo>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }

  public var body: some View {
    VStack(spacing: 32) {
      Text("PersonalInfo")

      TextField(
        "First Name",
        text: viewStore.binding(\.$firstName)
      )
      .autocorrectionDisabled()

      TextField(
        "Last Name",
        text: viewStore.binding(\.$lastName)
      )
      .autocorrectionDisabled()

      TextField(
        "Phone number",
        text: viewStore.binding(\.$phoneNumber)
      )
      .keyboardType(.phonePad)
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
struct PersonalInfoView_Previews: PreviewProvider {
  static var previews: some View {
    PersonalInfoView(
      store: Store(
        initialState: PersonalInfo.State(),
        reducer: PersonalInfo()
      )
    )
  }
}
#endif
