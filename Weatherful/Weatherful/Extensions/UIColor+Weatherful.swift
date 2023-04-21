//
//  UIColor+Weatherful.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//
import UIKit

extension UIColor {
    
    // MARK: - Text Colors
//    static let proudLightGrayText: UIColor = {
//        return UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
//    }()
//
//    static let proudGrayText: UIColor = {
//        return UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
//    }()
//
//    static let proudBlackText: UIColor = {
//        return UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
//    }()
    
    // MARK: - Background Colors
    // highlighted background
    static let customLightGrey: UIColor = {
            return UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        }()
    
    static let customDarkGrey: UIColor = {
        return UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }()
    
    static let customWhite: UIColor = {
        return .white
        }()
    
    static let customBlack: UIColor = {
        return UIColor(red: 32.0/255.0, green: 33.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        }()
    
//    static let customBlack: UIColor = {
//        return .black
//        }()
//    static let proudHighlightedBackground: UIColor = {
//        return UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
//    }()
//
//    // default white background
//    static let proudWhite: UIColor = {
//        return UIColor(white: 1.0, alpha: 1.0)
//    }()
    
    // MARK: - Other Colors
    // unselected icon, border
//    static let proudLightGray: UIColor = {
//        return UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
//    }()
//
//    static let proudTeal1: UIColor = {
//        return UIColor(red: 45.0/255.0, green: 201.0/255.0, blue: 235.0/255.0, alpha: 1.0)
//    }()
//
//    static let proudTeal2: UIColor = {
//        return UIColor(red: 20.0/255.0, green: 210.0/255.0, blue: 184.0/255.0, alpha: 1.0)
//    }()
    
    func imagify() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 0.5))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1.0, height: 0.5))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
