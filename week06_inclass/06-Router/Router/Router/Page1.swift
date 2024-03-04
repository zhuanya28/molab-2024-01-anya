//
//  UIImage from URL

import SwiftUI

// Array of image url strings
let imageArray = [
    "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/dan-osullivan1.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/alumni/ari_headshot.jpg.preset.square.jpeg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/GabePattern5.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/Sarah-Rothberg.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/clay-shirky.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/GeneralPics/katherinedillon.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/alumni/pedro.galvao.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/Luisa-Pereira.jpg.preset.square.jpeg",
    "https://tisch.nyu.edu/content/dam/tisch/itp/alumni/raaziq-brown.jpg.preset.square.jpeg?",
    "https://jht1493.net/a1/skt/assets/webdb/jht/IMG_4491.JPEG",
    "https://jht1493.net/a1/skt/assets/webdb/jht/IMG_7555.JPEG",
]

// Read in an image from the array of url strings
func imageFor( index: Int) -> UIImage {
    let urlStr = imageArray[index % imageArray.count]
    return imageFor(string: urlStr)
}

// Read in an image from a url string
func imageFor(string str: String) -> UIImage {
    let url = URL(string: str)
    let imgData = try? Data(contentsOf: url!)
    let uiImage = UIImage(data:imgData!)
    return uiImage!
}

struct Page1: View {
    var body: some View {
        VStack {
            ForEach(0 ..< 8) { index in
                Image(uiImage: imageFor(index: index))
                    .resizable()
                    .frame(width:100, height: 100)
            }
        }
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}

// https://tisch.nyu.edu/about/directory
