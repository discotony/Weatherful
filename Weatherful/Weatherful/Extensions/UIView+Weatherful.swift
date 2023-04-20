//
//  UIView+Weatherful.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/19/23.
//

import UIKit

extension UIView {
    
    // MARK: - Rounded Corners
    func circularize() {
        self.layer.cornerRadius = self.frame.width / 2.0
        self.clipsToBounds = true
    }

    func uncircularize() {
        self.layer.cornerRadius = 0
    }

    func roundCorners(cornerRadius: CGFloat = 15.0) {
        self.layer.cornerRadius = cornerRadius
    }

    // MARK: - Shadow
    func applyShadow(width: CGFloat = 0, height: CGFloat = 3.0) {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.customLightGrey.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.3
    }

    func applyDarkShadow(width: CGFloat = 0, height: CGFloat = 3.0) {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.customDarkGrey.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.3
    }
    
    // MARK: - Blur Effect
    func applyBlurEffect() {
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
//        self.insertSubview(blurEffectView, at: 0)
        self.addSubview(blurEffectView)
    }

    // MARK: - Animation
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

class ExpandableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        translatesAutoresizingMaskIntoConstraints = false

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}

