import SwiftTUI

// MARK: - Box Mover game
// Self-contained demo: horizontal mover. No shared globals with 2048.

private let moverBoxWidth = 9
private let moverTrackWidth = 33
private let moverMaxX = moverTrackWidth - moverBoxWidth

struct BoxMoverGameView: View {
  @State private var offsetX: Double = 0
  @State private var isMoving = false
  @State private var runID = 0

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      Text("Box Mover - horizontal demo").bold()

      ZStack(alignment: .topLeading) {
        Rectangle()
          .fill(.clear)
          .frame(width: moverTrackWidth, height: 5).offset(x: 0, y: 0)

        Text(String(repeating: "█", count: moverBoxWidth))
          .foregroundStyle(.blue)
          .offset(x: Int(offsetX.rounded()), y: 0)
      }
      .frame(width: moverTrackWidth + 2, height: 7)
      .border()

      HStack(spacing: 2) {
        Button(isMoving ? "[ Running... ]" : "[ Start ]") {
          guard !isMoving else { return }
          startMoving()
        }

        Button("[ Reset ]") {
          runID += 1
          withAnimation(.snappy(duration: .milliseconds(300))) {
            offsetX = 0
          }
          isMoving = false
        }
      }
    }
    .padding()
  }

  private func startMoving() {
    isMoving = true
    runID += 1
    let currentRun = runID
    withAnimation(.snappy(duration: .milliseconds(300))) {
      offsetX = Double(moverMaxX)
    }
    Task { @MainActor in
      try? await Task.sleep(nanoseconds: 1_600_000_000)
      if currentRun == runID {
        isMoving = false
      }
    }
  }
}
