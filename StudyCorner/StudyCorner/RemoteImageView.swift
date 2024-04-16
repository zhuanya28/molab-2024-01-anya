//
//  RemoteImageView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//

// THIS ONE IS LOADING + DISPLAYING THE IMAGE FROM UNSPLASH

import SwiftUI

struct RemoteImageView: View {
    let urlString: String
    @State private var image: Image? = nil
    
    var body: some View {
        if let image = image {
            image
                .resizable()
        } else {
            ProgressView()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.image = Image(uiImage: UIImage(data: data)!)
            }
        }.resume()
    }
}
