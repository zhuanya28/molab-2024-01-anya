

import UIKit
import Foundation
import SwiftUI

struct Page3: View {
    @State var selectedImage: UIImage?
    @State var backgroundColor: Color = .white
    @State var imagePicked = false
    
    var body: some View {
        ZStack {
            if let image = selectedImage {
                ZStack {
                    Color.clear
                    ImageView(uiImage: image)
                }
                .background(backgroundColor) // Apply the background color here
                .edgesIgnoringSafeArea(.all)
                
                Button("Change Photo") {
                    imagePicked = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                .offset(y: -300)
            } else {
                Button("Select Photo") {
                    imagePicked = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
        }
        .sheet(isPresented: $imagePicked) {
            PhotoPicker(selectedImage: $selectedImage, backgroundColor: $backgroundColor)
        }
        Spacer()
    }
}

