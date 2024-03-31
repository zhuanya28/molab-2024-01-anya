

import Foundation

import SwiftUI

struct Router: App {
    @StateObject var pageModel = PageModel();
    var body: some Scene {
        WindowGroup {
            ContentView(username: "stranger")
                .environmentObject(pageModel)
        }
    }
}

class PageModel: ObservableObject {
    @Published var pageTag: PageEnum = .LogIn
}

enum PageEnum {
    case Page1
    case Page2
    case LogIn
}

