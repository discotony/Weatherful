//
//  UIImage+Weatherful.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/21/23.
//

import UIKit

extension UIImage {
    static func animatedGif(named: String, framesPerSecond: Double = 10) -> UIImage? {
        guard let asset = NSDataAsset(name: named) else { return nil }
        return animatedGif(from: asset.data, framesPerSecond: framesPerSecond)
    }

    static func animatedGif(from data: Data, framesPerSecond: Double = 10) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let imageCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        for i in 0 ..< imageCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(images.count) / framesPerSecond)
    }
}

//extension UIImage {
//  public class func gif(asset: String) -> UIImage? {
//    if let asset = NSDataAsset(name: asset) {
//        return UIImage.gif(asset: asset.data)
//    }
//    return nil
//  }
//}
