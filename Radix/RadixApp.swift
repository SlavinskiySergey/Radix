import AppCoreFeature
import ComposableArchitecture
import SwiftUI

@main
struct RadixApp: App {
  let store = Store(
    initialState: AppCore.State(),
    reducer: AppCore()
  )

  var body: some Scene {
    WindowGroup {
      AppCoreView(store: self.store)
    }
  }
}
