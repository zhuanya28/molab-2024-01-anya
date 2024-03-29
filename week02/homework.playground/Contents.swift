
// Draw 10print style maze using UIGraphic and CGContext drawPath
// Write created image to local file
// https://developer.apple.com/documentation/coregraphics/cgcontext
//

import UIKit
let dim = 1024.0
let renderer = UIGraphicsImageRenderer(size: CGSize(width: dim, height: dim))

var image = renderer.image { (context) in
    let ctx = context.cgContext

    for row in stride(from: 0, through: dim, by: 5) {
        for col in stride(from: 0, through: dim, by: 5){
            let x = CGFloat(row)
            let y = CGFloat(col)
            // Set the stroke color before moving to the top of the current column
            ctx.setStrokeColor(UIColor.random().cgColor)
            
            ctx.move(to: CGPoint(x: x, y: 0))
            ctx.addLine(to: CGPoint(x: x, y: y))
    
            ctx.move(to: CGPoint(x: 0, y: y))
            ctx.addLine(to: CGPoint(x: x, y: y))
            
            ctx.setLineWidth(5.0)
            

            ctx.strokePath()
        }
    }
}

// extension to generate a random UIColor
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

// Display the image
image

//let data = image.pngData()
//
//let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//// Output path for the file in the Documents folder
//let filePath = folder!.appendingPathComponent("10print.png");
//
//let err: ()? = try? data?.write(to: filePath)
//print("err \(String(describing: err))\nfilePath \(filePath)")
//// Terminal command string to copy output file to Downloads folder
//print("cp \(filePath.absoluteString.dropFirst(7)) ~/Downloads/10print.png" )

// Terminal command to copy the image file to the downloads folder
// cp --filePath-- ~/Downloads/.


