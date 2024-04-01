//
//  week08App.swift
//  week08
//
//  Created by anya zhukova on 3/31/24.
//

import SwiftUI

@main
struct week08App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PageModel())
        }
    }
}
