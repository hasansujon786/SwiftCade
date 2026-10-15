import SwiftTUI

// MARK: - 2048 game
// Self-contained: everything this game needs lives in this folder.
// Nothing here leaks globals — helpers are `private` to this file.

private struct BoxSize {
  let width: Int
  let height: Int
}

private let defaultBoxSize = BoxSize(width: 11, height: 5)
private let boardCellCount = 3

private let frameSize = BoxSize(
  width: defaultBoxSize.width * boardCellCount, height: defaultBoxSize.height * boardCellCount)
private let maxOffsetY = frameSize.height - defaultBoxSize.height

private struct NumberBoxView: View {
  let number: Int
  let textColor: Color
  let boxColor: Color
  var width: Int = defaultBoxSize.width
  var height: Int = defaultBoxSize.height

  var body: some View {
    VStack(spacing: 0) {
      ForEach(0..<height) { row in
        if row == height / 2 {
          numberRow
        } else {
          Text(String(repeating: "█", count: width)).foregroundStyle(boxColor)
        }
      }
    }
  }

  private var numberRow: some View {
    let label = "\(number)"
    let trimmed = label.count > width ? String(label.prefix(width)) : label
    let totalPad = width - trimmed.count
    let leftCount = totalPad / 2
    let rightCount = totalPad - leftCount
    return Text(
      "\(Text(String(repeating: "█", count: leftCount)).foregroundStyle(boxColor))\(Text(trimmed).foregroundStyle(textColor))\(Text(String(repeating: "█", count: rightCount)).foregroundStyle(boxColor))"
    ).background(boxColor)
  }
}

struct TwentyFortyEightGameView: View {
  @State private var offsetY: Double = 0
  @State private var isMoving = false
  @State private var runID = 0

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      Text("2048 - Box Animation")
        .bold()

      ZStack(alignment: .topLeading) {
        Rectangle()
          .fill(.clear)
          .frame(width: frameSize.width, height: frameSize.height).offset(x: 0, y: 0)

        NumberBoxView(number: 256, textColor: .black, boxColor: .green)
          .offset(x: 0, y: Int(offsetY.rounded()))
      }
      .frame(width: frameSize.width + 2, height: frameSize.height + 2)
      .border()

      HStack(spacing: 2) {
        Button(isMoving ? "[ Running... ]" : "[ Start ]") {
          guard !isMoving else { return }
          startMoving()
        }

        Button("[ Reset ]") {
          runID += 1
          withAnimation(.snappy(duration: .milliseconds(300))) {
            offsetY = 0
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
      offsetY = Double(maxOffsetY)
    }
    Task { @MainActor in
      try? await Task.sleep(nanoseconds: 1_600_000_000)
      if currentRun == runID {
        isMoving = false
      }
    }
  }
}
