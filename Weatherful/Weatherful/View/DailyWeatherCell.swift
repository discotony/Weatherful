//
//  DailyWeatherCell.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        setUpPlaceHolder()
    }
    
    private func setUpUI() {
        dayLabel.configure(font: CustomFonts.captionSmall!)
        dateLabel.configure(font: CustomFonts.captionSmall!)
        conditionImageView.tintColor = .customBlack
        maxTempLabel.configure(font: CustomFonts.captionSmall!)
        minTempLabel.configure(font: CustomFonts.captionSmall!)
    }
    
    private func setUpPlaceHolder() {
        dayLabel.text = "Sunday"
        dateLabel.text = "4/20"
        conditionImageView.image = UIImage(systemName: "sun.max")
        maxTempLabel.text = "72°F"
        minTempLabel.text = "40°F"
    }

}
