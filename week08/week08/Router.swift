

import Foundation

import SwiftUI

struct Router: App {
    @StateObject var pageModel = PageModel();
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pageModel)
        }
    }
}

class PageModel: ObservableObject {
    @Published var pageTag: PageEnum = .LogIn
    @Published var username: String = "stranger"
}

enum PageEnum {
    case LogIn
    case Page1
    case Page2
    case Page3
}

