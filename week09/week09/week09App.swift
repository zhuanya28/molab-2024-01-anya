//
//  week09App.swift
//  week09
//
//  Created by anya zhukova on 4/8/24.
//

import SwiftUI

@main
struct week09App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PageModel())
        }
    }
}
