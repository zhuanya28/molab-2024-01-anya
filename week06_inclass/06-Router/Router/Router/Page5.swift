//
// UIImage named from Resource folder

import SwiftUI
import UIKit

struct Page5: View {
    @State var len = 400.0
    @State var fitFlag = true
    @State var selectedImage = "circle"
    var body: some View {
        VStack() {
            Spacer()
            ZStack {
                //-- image from app bundle
                // Image(uiImage: UIImage(named: "jht.jpg")!)
                //-- image from Assets.xcassets
                Image("jht")
                    .resizable()
                    .aspectRatio(contentMode: fitFlag ? .fit : .fill)
                    .frame(width:len, height: len)
                //-- image from SF Symbols
                Image(systemName: selectedImage)
                    .resizable()
                    .frame(width:len, height: len)
            }
            Spacer()
            Toggle(isOn: $fitFlag) {
                Text("Fit")
            }
            Slider(value: $len, in: 100.0...800.0)
            Text("len \(len)")
            Picker("Image Name", selection: $selectedImage) {
                Text("circle").tag("circle")
                Text("flag").tag("flag")
                Text("ear").tag("ear")
            }
        }
    }
}

struct Page5_Previews: PreviewProvider {
    static var previews: some View {
        Page5()
    }
}


