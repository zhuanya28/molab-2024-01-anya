//
//  RemindersMainView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/28/24.
//

import SwiftUI

struct RemindersMainView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Text("Hello, World!")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton())
        }
        
  
    }
    
    
        
}

#Preview {
    RemindersMainView()
}
