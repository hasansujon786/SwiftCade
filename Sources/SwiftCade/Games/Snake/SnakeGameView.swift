import SwiftTUI

// MARK: - Snake game (placeholder)
// Uses router.push / router.pop like every other screen.

struct SnakeGameView: View {
  @Environment(AppRouter.self) private var router: AppRouter

  @State private var score = 0

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      Text("Snake is not built yet.")
      Text("Score (local @State): \(score)").foregroundStyle(.secondary)
      HStack(spacing: 2) {
        Button("[ +1 Score ]") { score += 1 }
        Button("[ Open Settings ]") { router.showSettings() }
      }
    }
    .padding()
  }
}
