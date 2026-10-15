import SwiftTUI

// Dispatcher only — each game's UI lives in Games/<Name>/.
// Uses router.pop() / router.showSettings() instead of closures.
struct GameHostView: View {
  let game: GameID
  @Environment(AppRouter.self) private var router: AppRouter

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      BackBar(title: game.title) { router.pop() }
      Text(game.subtitle).foregroundStyle(.secondary)

      switch game {
      case .boxMover:
        BoxMoverGameView()
      case .twentyFortyEight:
        TwentyFortyEightGameView()
      case .snake:
        SnakeGameView()
      }
    }
    .navigationTitle(game.title)
  }
}
