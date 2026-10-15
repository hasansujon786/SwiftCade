import SwiftTUI

/// Root of the stack. Push via `router.push(...)` — no raw path handling here.
struct HomeView: View {
  @Environment(AppRouter.self) private var router: AppRouter

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      Text("SWIFTCADE").bold()
      Text("Pick a game:").foregroundStyle(.secondary)

      ForEach(GameID.allCases) { game in
        Button("[ > \(game.title) ]") {
          router.push(game: game)
        }
      }

      Text("")
      Button("[ Settings ]") {
        router.showSettings()
      }

      Text("").foregroundStyle(.secondary)
      Text("Depth: \(router.depth)").foregroundStyle(.secondary)
    }
    .padding()
    .navigationTitle("Home")
  }
}
