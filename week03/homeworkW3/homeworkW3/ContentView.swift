//
//  ContentView.swift
//  homeworkW3
//
//  Created by anya zhukova on 2/11/24.
//

import SwiftUI

struct ContentView: View {
    let imageNames = ["star.fill", "circle.fill", "square.fill", "triangle.fill"]
    @State private var randomColors: [Color] = []

       var body: some View {
           VStack {
               ForEach(imageNames.indices, id: \.self) { index in
                   Image(systemName: imageNames[index])
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 100, height: 100)
                       .foregroundColor(randomColors[index])
                       .padding()
               }
               Button("MobLab Dev Application Image") {
                   self.generateRandomColor()
               }
               .padding()
           }
       }

    func generateRandomColor() {
        randomColors = (0..<imageNames.count).map { _ in
            Color(red: Double.random(in: 0...1),
                  green: Double.random(in: 0...1),
                  blue: Double.random(in: 0...1))
        }
    }
}

#Preview {
    ContentView()
}
