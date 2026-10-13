import SwiftTUI

struct NumberBoxView: View {
  let number: Int
  let textColor: Color
  let boxColor: Color
  var width: Int = 11
  var height: Int = 5

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

struct MovingBoxView: View {
  @State private var offsetX: Double = 0
  @State private var offsetY: Double = 0
  @State private var isMoving: Bool = false
  @State private var runID: Int = 0

  private let maxOffsetX = 22
  private let maxOffsetY = 10

  var body: some View {
    VStack(alignment: .leading, spacing: 1) {
      Text("SwiftTUI Box Animation")
        .bold()

      // The moving box track: background reserves size,
      // box + markers overlay via ZStack + offset (no space hack)
      ZStack(alignment: .topLeading, ) {
        // Track placeholder: defines the layout size
        Rectangle()
          .fill(.clear)
          .frame(width: 33, height: 15).offset(x: 0, y: 0)

        // Moving box on top
        NumberBoxView(number: 256, textColor: .black, boxColor: .green)
          .offset(x: Int(offsetX.rounded()), y: Int(offsetY.rounded()))
        // NumberBoxView(number: 256, textColor: .black, boxColor: .red)
        //   .offset(x: 11, y: 0)
        // NumberBoxView(number: 256, textColor: .black, boxColor: .blue)
        //   .offset(x: 22, y: 0)

        // Moving box on top
        // NumberBoxView(number: 256, textColor: .black, boxColor: .red)
        //   .offset(x: Int(offset.rounded()), y: 5)
        // NumberBoxView(number: 256, textColor: .black, boxColor: .green)
        //   .offset(x: 11, y: 5)
        // NumberBoxView(number: 256, textColor: .black, boxColor: .red)
        //   .offset(x: 22, y: 5)
        //
        // // Moving box on top
        // NumberBoxView(number: 256, textColor: .black, boxColor: .blue)
        //   .offset(x: Int(offset.rounded()), y: 10)
        // NumberBoxView(number: 256, textColor: .black, boxColor: .red)
        //   .offset(x: 11, y: 10)
        // NumberBoxView(number: 256, textColor: .black, boxColor: .green)
        //   .offset(x: 22, y: 10)
      }
      .frame(width: 35, height: 17)
      .border()

      // Controls
      HStack(spacing: 2) {
        Button(isMoving ? "[ Running... ]" : "[ Start ]") {
          guard !isMoving else { return }
          startMoving()
        }

        Button("[ Reset ]") {
          runID += 1
          withAnimation(.snappy(duration: .milliseconds(300))) {
            // offsetX = 0
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
    // Physics-based spring: smooth accelerate + gentle settle.
    // Try .smooth / .snappy / .bouncy, or tune duration + bounce.
    withAnimation(
      .snappy(duration: .milliseconds(300))
      // .spring(duration: .seconds(1.2), bounce: 0.2)
    ) {
      // offsetX = Double(maxOffsetX)
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

@main
struct MovingBoxApp: App {
  var body: some Scene {
    WindowGroup("MovingBox") { MovingBoxView() }
  }
}
