//
//  ContentView.swift
//  homeworkW3
//
//  Created by anya zhukova on 2/11/24.
//

import SwiftUI

struct ContentView: View {
    //    @State private var randomColors: [Color] = []
    @State private var imageNames = ["star.fill", "circle.fill", "square.fill", "triangle.fill", "beats.studiobuds.chargingcase", "music.mic.circle.fill", "octagon.lefthalf.filled", "arrow.up.to.line.circle.fill"]
        @State private var  colors : [UIColor] = [.green, .orange, .red, .black, .blue, .brown, .white, .purple]
    
    func generateRandomData() {
        imageNames.shuffle()
        //        colors.shuffle()
    }
    
    var body: some View {
        VStack {
//            ForEach(colors, id: \.self) { item in
//                
//                
//            }
            ForEach(imageNames.indices, id: \.self) { index in
                if let imageNameIndex = imageNames.firstIndex(of: imageNames[index]) {
                    //                               let currentColor = colors[imageNameIndex]
                    Image(systemName: imageNames[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.random())
                        .padding()
                }
            }
            
            Button("Generate new pattern!") {
                self.generateRandomData()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
