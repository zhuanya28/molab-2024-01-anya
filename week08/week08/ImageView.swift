//
//  ImageView.swift
//  week07
//
//  Created by anya zhukova on 3/24/24.
//

import SwiftUI

struct ImageView: View {
    var uiImage: UIImage
    
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .cornerRadius(10)
    }
}
