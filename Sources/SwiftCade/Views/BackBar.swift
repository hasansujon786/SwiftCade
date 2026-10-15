import SwiftTUI

/// Reusable top bar: [ <- Back ] + title. Pop is just `path.removeLast()`.
struct BackBar: View {
  let title: String
  var onBack: @MainActor @Sendable () -> Void

  var body: some View {
    HStack(spacing: 2) {
      Button("[ <- Back ]") { onBack() }
      Text(title).bold()
    }
  }
}
