//
//  DailyWeatherCell.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {

    @IBOutlet weak var overlayView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
//        setUpPlaceHolder()
    }
    
    private func setUpUI() {
        overlayView.roundCorners(cornerRadius: 20)
        overlayView.backgroundColor = .customLightGrey.withAlphaComponent(0.25)
        dateLabel.configure(font: CustomFonts.captionSmall!)
        timeLabel.configure(font: CustomFonts.captionSmall!)
        conditionImageView.tintColor = .customBlack
        maxTempLabel.configure(font: CustomFonts.captionSmall!)
        minTempLabel.configure(font: CustomFonts.captionSmall!)
    }
    
//    private func setUpPlaceHolder() {
//        dayLabel.text = "Sunday"
//        dateLabel.text = "4/20"
//        conditionImageView.image = UIImage(systemName: "sun.max")
//        maxTempLabel.text = "72°F"
//        minTempLabel.text = "40°F"
//    }

}
