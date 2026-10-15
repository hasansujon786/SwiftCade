import SwiftTUI

/// Owns the navigation stack via ArcadeRouter (custom Push/Pop, SwiftUI-like).
struct ArcadeRootView: View {
  @State private var router = AppRouter()

  var body: some View {
    NavigationStack(path: router.pathBinding()) {
      HomeView()
        .navigationDestination(for: Route.self) { route in
          switch route {
          case .game(let game):
            GameHostView(game: game)
          case .settings:
            SettingsView()
          }
        }
    }
    .environment(router)
  }
}
