//
//  Item struct for more info about image

import SwiftUI

import UIKit

struct Item : Identifiable {
    let id = UUID()
    var urlStr:String
    var label:String
}

// Array of image url strings
let imageItems:[Item] = [
    Item(urlStr: imageArray[0], label:"Dan O"),
    Item(urlStr: imageArray[1], label:"Ari"),
    Item(urlStr: imageArray[2], label:"Gabe"),
    Item(urlStr: imageArray[3], label:"Sarah"),
    Item(urlStr: imageArray[4], label:"Clay"),
    Item(urlStr: imageArray[5], label:"Katherine"),
    Item(urlStr: imageArray[6], label:"Pedro"),
    Item(urlStr: imageArray[7], label:"Luisa"),
    Item(urlStr: imageArray[8], label:"Raaziq"),
    Item(urlStr: imageArray[9], label:"jht1"),
    Item(urlStr: imageArray[10], label:"jht2"),
]


struct Page2: View {
    var body: some View {
        VStack {
            ForEach(imageItems) { item in
                HStack {
                    Image(uiImage: imageFor(string: item.urlStr))
                        .resizable()
                        .frame(width:100, height: 100)
                    Text(item.label)
                    Spacer()
                }
            }
        }
    }
}

struct Page2_Previews: PreviewProvider {
    static var previews: some View {
        Page2()
    }
}
