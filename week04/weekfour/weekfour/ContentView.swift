//
//  ContentView.swift
//  weekfour
//
//  Created by anya zhukova on 2/24/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        TabView {
            CountdownTimerPage()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Timer 1")
                }

            AudioPlayerPage()
                .tabItem {
                    Image(systemName: "speaker.fill")
                    Text("Audio Player")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
