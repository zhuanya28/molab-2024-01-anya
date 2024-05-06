//
//  CustomBackButtonB.swift
//  StudyCorner
//
//  Created by anya zhukova on 5/5/24.
//

import SwiftUI

struct CustomBackButtonB: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.backward")
                .foregroundColor(.black)
                .padding(.horizontal)
        }
    }
}


