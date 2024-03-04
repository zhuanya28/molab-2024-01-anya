//
//  MainView.swift
//  Router
//
//  Created by anya zhukova on 3/4/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var pageModel: PageModel
    
    var body: some View {
        switch pageModel.pageTag {
        case .Page1:
            Page1()
        case .Page2:
            Page2()
        case .Page3:
            Page3()
        case .Page4:
            Page4()
        case .Page5:
            Page5()
        }
        Text("Hello world")
        HStack{
            Button(action: {
                pageModel.pageTag = .Page1
            }){
                Text("[Page1]")
            }
            Button(action: {
                pageModel.pageTag = .Page2
            }){
                Text("[Page2]")
            }
            Button(action: {
                pageModel.pageTag = .Page3
            }){
                Text("[Page3]")
            }
        }
        
    }
}

#Preview {
    MainView()
        .environmentObject(PageModel())
}
