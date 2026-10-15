// MARK: - Stack navigation model (Push / Pop)
// Game list lives in Games/GameID.swift. Route only says *where* we are.

enum Route: Hashable, Sendable {
  case game(GameID)
  case settings
}
