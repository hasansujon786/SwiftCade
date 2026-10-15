import SwiftTUI

/// Demo settings menu. Pops via `router.pop()` — SwiftUI's `dismiss` equivalent.
struct SettingsView: View {
  @Environment(AppRouter.self) private var router: AppRouter

  @State private var soundOn = true
  @State private var showFPS = false
  @State private var difficulty = 1 // 0 easy, 1 normal, 2 hard

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      BackBar(title: "Settings (demo)") { router.pop() }

      Toggle("Sound", isOn: $soundOn)
      Toggle("Show FPS", isOn: $showFPS)

      HStack(spacing: 2) {
        Text("Difficulty:")
        Button(difficultyLabel(0)) { difficulty = 0 }
        Button(difficultyLabel(1)) { difficulty = 1 }
        Button(difficultyLabel(2)) { difficulty = 2 }
      }

      Text("Sound is \(soundOn ? "ON" : "OFF")").foregroundStyle(.secondary)
      Text("Current: \(["Easy", "Normal", "Hard"][difficulty])").foregroundStyle(.secondary)

      Text("")
      Button("[ Pop to Home ]") { router.popToRoot() }
    }
    .padding()
    .navigationTitle("Settings")
  }

  private func difficultyLabel(_ index: Int) -> String {
    let name = ["Easy", "Normal", "Hard"][index]
    return difficulty == index ? "[ \(name) * ]" : "[ \(name) ]"
  }
}
