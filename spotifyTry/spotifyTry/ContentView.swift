//
//  ContentView.swift
//  spotifyTry
//
//  Created by anya zhukova on 4/22/24.
//

#import <SpotifyiOS/SpotifyiOS.h>
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
