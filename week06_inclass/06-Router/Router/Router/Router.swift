//
//  ImageUiDemo_urlsApp.swift
//  ImageUiDemo-urls
//
//  Created by jht2 on 9/14/23.
//

import SwiftUI

@main
struct Router: App {
    @StateObject var pageModel = PageModel();
    var body: some Scene {
        WindowGroup {
            // This is the starting page for the app
            MainView()
                .environmentObject(pageModel)
        }
    }
}

class PageModel: ObservableObject{
    @Published var pageTag : PageEnum = .Page1
}

enum PageEnum {
    case Page1
    case Page2
    case Page3
    case Page4
    case Page5
}
