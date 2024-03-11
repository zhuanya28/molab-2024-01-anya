//
//  Router.swift
//  week06
//
//  Created by anya zhukova on 3/8/24.
//

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
}

enum PageEnum {
    case Page1
    case Page2
    case LogIn
}

