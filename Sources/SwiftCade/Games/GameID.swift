// MARK: - Game registry
// To add a game: 1) add a case here, 2) add its folder under Games/<Name>/,
// 3) add one branch in Views/GameHostView.swift. Nothing else changes.

enum GameID: String, Hashable, Sendable, CaseIterable, Identifiable {
  case boxMover
  case twentyFortyEight
  case snake

  var id: String { rawValue }

  var title: String {
    switch self {
    case .boxMover: "Box Mover (animation demo)"
    case .twentyFortyEight: "2048 (board demo)"
    case .snake: "Snake (coming soon)"
    }
  }

  var subtitle: String {
    switch self {
    case .boxMover: "Horizontal bounce demo, self-contained"
    case .twentyFortyEight: "Vertical box animation, self-contained"
    case .snake: "Placeholder to show how a new game plugs in"
    }
  }
}
