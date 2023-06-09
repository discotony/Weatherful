//
//  UILabel+Weatherful.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import UIKit

extension UILabel {
    func configure(text: String? = nil, font: UIFont, color: UIColor = .customBlack, isCenterAligned: Bool = false) {
        if let text = text { self.text = text }
        self.font = font
        self.textColor = color
        if isCenterAligned { self.textAlignment = .center }
    }

    func applyLabelShadow(isDarkText: Bool) {
        if isDarkText {
            self.layer.shadowColor = UIColor.customWhite.cgColor
        } else {
            self.layer.shadowColor = UIColor.customBlack.cgColor
        }
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
}
