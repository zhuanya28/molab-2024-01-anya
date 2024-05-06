//
//  UIImage+Extension.swift
//  StudyCorner
//
//  Created by anya zhukova on 5/6/24.
// Credits to the inspiration: https://oguzhanaslann.medium.com/implementing-dynamic-background-color-from-images-in-swift-96e71dd73599
//


extension UIImage {
    func averageColor(withDarkeningFactor darkeningFactor: CGFloat) -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)
        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

       
        let red = CGFloat(bitmap[0]) / 255 * darkeningFactor
        let green = CGFloat(bitmap[1]) / 255 * darkeningFactor
        let blue = CGFloat(bitmap[2]) / 255 * darkeningFactor

        return UIColor(red: red,
                       green: green,
                       blue: blue,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}

