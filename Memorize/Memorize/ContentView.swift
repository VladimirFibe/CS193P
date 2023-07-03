import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🚕", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚜", "🚲", "🛵", "🛺", "🚔", "🚍", "🚖", "🚃", "🚋", "🚂", "✈️", "🚀", "🛸", "🚁", "🛶", "⛵️", "🚤", "🛳️", "🚈", "🚊", "🚠"]
    @State var emojiCount = 20
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 10)], spacing: 10) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                    }
                }
            }
            HStack {
                remove
                Spacer()
                add
            }
        }
        .foregroundColor(.red)
        .padding()
    }
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        }
        .disabled(emojiCount == emojis.count)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
                .imageScale(.large)
        }
        .disabled(emojiCount == 1)
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
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        .aspectRatio(2/3, contentMode: .fill)
    }
}
