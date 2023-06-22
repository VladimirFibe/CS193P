import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("👻")
                .font(.largeTitle)
        }
        .foregroundColor(.red)
        .padding()
    }
}

#Preview {
    ContentView()
}
