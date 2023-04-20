//
//  MainVC.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/19/23.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    
    
    @IBOutlet weak var currentLocationButtonView: UIView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchLocationButtonView: UIView!
    @IBOutlet weak var searchLocationButtonViewWidth: NSLayoutConstraint!
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    
    @IBOutlet weak var hourlyWeatherBackgroundView: UIView!
    
    
    private var shouldCollapse = false
//    var buttonTitle: String {
//    return shouldCollapse ? "Show Less" : "Show More"
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpPlaceHolders()
        
    }

    private func setUpUI() {
        backgroundImageView.image = UIImage(named: "cloud.rain")
        backgroundImageView.contentMode = .scaleAspectFill
//        backgroundImageView.applyBlurEffect()
        overlayView.backgroundColor = .clear
//        overlayView.applyBlurEffect()
        
//        expandableSearchView.backgroundColor = .customWhite.withAlphaComponent(0.75)
//        expandableSearchView.roundCorners(cornerRadius: 20)
        
        currentLocationButtonView.backgroundColor = .customWhite.withAlphaComponent(0.75)
        currentLocationButtonView.circularize()
        currentLocationButtonView.applyShadow()
        currentLocationButton.tintColor = .customBlack
        
        searchLocationButtonView.backgroundColor = .customWhite.withAlphaComponent(0.75)
        searchLocationButtonView.roundCorners(cornerRadius: 20)
        searchLocationButtonView.applyShadow()
        searchLocationButton.tintColor = .customBlack
        cityLabel.configure(font: CustomFonts.captionMedium!, color: .customBlack)
        
        currentTempLabel.configure(font: CustomFonts.titleXL!)
        conditionLabel.configure(font: CustomFonts.captionMedium!)
        maxMinTempLabel.configure(font: CustomFonts.captionMedium!)
        
        hourlyWeatherBackgroundView.backgroundColor = .customLightGrey.withAlphaComponent(0.2)
        hourlyWeatherBackgroundView.roundCorners(cornerRadius: 25.0)
//        hourlyWeatherBackgroundView.layer.borderWidth = 2.0
        
 

    }
    
    
    
    private func setUpPlaceHolders() {
        cityLabel.text = "San Francisco, CA"
        currentTempLabel.text = "72°F"
        conditionLabel.text = "Mostly Clear"
        maxMinTempLabel.text = "H: 75°F L: 56°F"
        

    }
    
    // MARK: - UIActions
    @IBAction func SearchLocationButtonPressed(_ sender: Any) {
        let newWidth = view.layer.frame.width - (currentLocationButtonView.frame.maxX + 32)
        
        if shouldCollapse {
            animateView(isCollapsed: false, widthConstraint: 0)
            } else {
                animateView(isCollapsed: true, widthConstraint: newWidth)
            }
    }
    
    private func animateView(isCollapsed: Bool, widthConstraint: Double) {
        shouldCollapse = isCollapsed
    
        
        searchLocationButtonViewWidth.constant = CGFloat(widthConstraint)
        
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
       }
    }
}
