//
//  ContentView.swift
//  week06
//
//  Created by anya zhukova on 3/8/24.
//

import SwiftUI

struct ContentView: View {
//    var username: String
    @EnvironmentObject var pageModel: PageModel;
    var body: some View {
        VStack {
            
            
            switch pageModel.pageTag {
            case .Page1:
                Page1()
            case .Page2:
                Page2()
            }
           
            Spacer()
            
    
            HStack {
                Button(action: {
                    pageModel.pageTag = .Page1
                }) {
                    Text("Focus")
                    
                }
                
                Button(action: {
                    pageModel.pageTag = .Page2
                }) {
                    Text("Encouragement")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PageModel())
}
