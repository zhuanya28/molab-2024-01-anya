//
//  ContentView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
// heavily relying on this youtube video : https://www.youtube.com/watch?v=CmOe9vNopjU
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var searchObjectController = SearchObjectController.shared
    @State private var randomIndex: Int = 1
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if !searchObjectController.results.isEmpty {
                RemoteImageView(urlString: searchObjectController.results[randomIndex].urls.small)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 3)
                    .overlay(Color.black.opacity(0.6))
                    .zIndex(0)
                    .id(randomIndex)
            } else {
                Text("No results")
            }
            
            VStack {
                Spacer()
                
                Spacer()
                
                Spacer()
                
                TimerView()
                    .zIndex(2)
                
                Button(action: {
                    shuffleImages()
                }) {
                    Image(systemName: "shuffle")
                        .font(.title)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .zIndex(2)
                .padding()
            }
        }
        .onAppear {
            searchObjectController.search()
            randomIndex = searchObjectController.results.indices.randomElement() ?? 0
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
    
    private func shuffleImages() {
        guard !searchObjectController.results.isEmpty else { return }
        
        var newIndex = randomIndex
        
        while newIndex == randomIndex {
            newIndex = searchObjectController.results.indices.randomElement()!
        }
        
        randomIndex = newIndex
    }
}

#Preview{
        ContentView()
}
