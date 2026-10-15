import Observation
import SwiftTUI

// MARK: - Custom Push / Pop system (SwiftUI-like)
//
// SwiftUI shape:
//   @Environment(ArcadeRouter.self) var router
//   router.push(.game(id))   // instead of path.append(...)
//   router.pop()             // instead of path.removeLast()
//   router.popToRoot()       // instead of path.removeAll()
//
// The router owns the path. ArcadeRootView injects it with `.environment(router)`
// and drives `NavigationStack(path:)` from it.

@MainActor
@Observable
final class AppRouter {
  var path: [Route] = []

  var canPop: Bool { !path.isEmpty }
  var depth: Int { path.count }

  // MARK: Push

  func push(_ route: Route) {
    path.append(route)
  }

  func push(game: GameID) {
    push(.game(game))
  }

  func showSettings() {
    push(.settings)
  }

  // MARK: Pop

  func pop() {
    guard !path.isEmpty else { return }
    path.removeLast()
  }

  func pop(count: Int) {
    guard count > 0, !path.isEmpty else { return }
    path.removeLast(min(count, path.count))
  }

  func popToRoot() {
    path.removeAll()
  }

  // MARK: Replace (useful for game-over -> home, etc.)

  func replace(with route: Route) {
    if path.isEmpty {
      path.append(route)
    } else {
      path[path.count - 1] = route
    }
  }

  func replaceAll(with routes: [Route]) {
    path = routes
  }
}

// MARK: - Binding bridge
// NavigationStack needs a Binding<[Route]>. Built explicitly so we don't
// depend on dynamicMember magic — works with @State-held Observable router.
extension AppRouter {
  func pathBinding() -> Binding<[Route]> {
    Binding(get: { self.path }, set: { self.path = $0 })
  }
}
