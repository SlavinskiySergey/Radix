import ComposableArchitecture
import Models
import SwiftUI

public struct LoggedInView: View {
  let store: StoreOf<LoggedIn>
  @ObservedObject var viewStore: ViewStoreOf<LoggedIn>

  public init(store: StoreOf<LoggedIn>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }

  public var body: some View {
    VStack(spacing: 32) {
      Text("Main screen")

      Text("Hi, \(viewStore.user.firstName) \(viewStore.user.lastName)")

      Text("phone: \(viewStore.user.phoneNumber)")

      Button("Logged Out") {
        viewStore.send(.loggedOutTapped)
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

#if DEBUG
struct LoggedInView_Previews: PreviewProvider {
  static var previews: some View {
    LoggedInView(
      store: Store(
        initialState: LoggedIn.State(
          user: User(
            firstName: "First_Name",
            lastName: "Last_Name",
            phoneNumber: "1234567890")
        ),
        reducer: LoggedIn()
      )
    )
  }
}
#endif
