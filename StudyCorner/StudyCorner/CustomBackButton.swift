//
//  CustomBackButton.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/28/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.backward")
                .foregroundColor(.white)
                .padding(.horizontal)
        }
    }
}

#Preview {
    CustomBackButton()
}
