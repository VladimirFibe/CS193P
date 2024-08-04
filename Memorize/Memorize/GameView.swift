import SwiftUI

struct GameView: View {
    var body: some View {
        HStack {
            CardView()
            CardView(isFaceUp: false)
            CardView()
            CardView(isFaceUp: false)
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = true
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 12)
        ZStack {
            if isFaceUp {
                shape.foregroundStyle(.white)
                shape.strokeBorder(lineWidth: 2)
                Text("🎃").font(.largeTitle)
            } else {
                shape
            }
        }
    }
}

#Preview {
    GameView()
}
