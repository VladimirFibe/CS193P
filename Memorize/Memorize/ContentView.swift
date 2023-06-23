import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🚕", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚜", "🚲", "🛵", "🛺", "🚔", "🚍", "🚖", "🚃", "🚋", "🚂", "✈️", "🚀", "🛸", "🚁", "🛶", "⛵️", "🚤", "🛳️", "🚈", "🚊", "🚠"]
    @State var emojiCount = 3
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            HStack {
                Button {
                    emojiCount -= 1
                } label: {
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                }
                Spacer()
                Button {
                    emojiCount += 1
                } label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill(Color.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
