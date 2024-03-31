//
//  ContentView.swift
//  week06
//
//  Created by anya zhukova on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    var username: String
    @EnvironmentObject var pageModel: PageModel;
    var body: some View {
        VStack {
            switch pageModel.pageTag {
            case .Page1:
                Page1(username: username)
            case .Page2:
                Page2(username: username)
            case .LogIn:
                LogInPage()
            }
           
            Spacer()
            
    
            VStack {
                Button(action: {
                    pageModel.pageTag = .LogIn
                }) {
                    Text("Profile")
                        .foregroundColor(.purple)
                    
                }
                Button(action: {
                    pageModel.pageTag = .Page1
                }) {
                    Text("Focus")
                        .foregroundColor(.purple)
                    
                }
                
                Button(action: {
                    pageModel.pageTag = .Page2
                }) {
                    Text("Encouragement")
                        .foregroundColor(.purple)
                }
            }
        }
    }
}

#Preview {
    ContentView(username: "stranger")
        .environmentObject(PageModel())
}
