//
//  CustomFonts.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import UIKit

struct CustomFonts {
    // MARK: - List of Fonts
    // SFProDisplay-Heavy
    // SFProText-Regular
    // SFProRounded-Bold
    // SFProRounded-Regular
    // SFProRounded-Medium

    /*
    // Feed Section Header
    static let headerBig = UIFont(name: "SFProDisplay-Heavy", size: 24.0)
    // Non-Feed Section Header
    static let header = UIFont(name: "SFProDisplay-Heavy", size: 18.0)

    // Story: Story Detail Big Title
    static let titleBig = UIFont(name: "SFProRounded-Bold", size: 36.0)
    // Story: Story Detail Ttile
    static let title = UIFont(name: "SFProRounded-Bold", size: 24.0)
    // Feed: Spotlight Story Title
    static let titleMedium = UIFont(name: "SFProRounded-Bold", size: 18.0)
    // Feed: Story Title
    // Story: Author Name
    // Profile: Story Title
    // Navigation Bar: Title
     */
    
    static let titleXL = UIFont(name: "SFProRounded-Bold", size: 102.0)
    static let titleSmall = UIFont(name: "SFProRounded-Medium", size: 14.0)
    // MARK: - City Label
    static let captionLarge = UIFont(name: "SFProRounded-Medium", size: 20.0)
    static let captionMedium = UIFont(name: "SFProRounded-Regular", size: 16.0)
    static let captionSmall = UIFont(name: "SFProRounded-Medium", size: 14.0)
//    static let titleSmall = UIFont(name: "SFProRounded-Bold", size: 16.0)

    /*
    // Feed: Name
    // Profile: Name
    static let captionBold = UIFont(name: "SFProRounded-Bold", size: 12.0)
    // Feed: Story Description, Quote Name, More Button
    // Story: Author Description
    // Profile: Story Description, More Button
    // Comment: More Button
    static let caption = UIFont(name: "SFProRounded-Medium", size: 12.0)

    // Feed: Story Type
    // Profile: Bio - Pronoun
    // Comment: Name
    static let textRoundedSmall = UIFont(name: "SFProRounded-Bold", size: 14.0)
    // Feed: Quote Text
    // Story: Story Type
    // Profile-Edit: Bio
    // Navigation Bar: Button Text
    // Search: Button Text
    static let textRounded = UIFont(name: "SFProRounded-Medium", size: 16.0)
    // Story: Story Text
    static let text = UIFont(name: "SFProText-Regular", size: 16.0)


    // Profile: Profile Name
    static let profileName = UIFont(name: "SFProRounded-Heavy", size: 24.0)

    // Comment: Text
    static let comment = UIFont(name: "SFProRounded-Regular", size: 14.0)

    // Profile: Bio - Location
    // Comment: Button Text
    static let smallButton = UIFont(name: "SFProRounded-Medium", size: 14.0)
     */
}

func listFontNames() {
    for family: String in UIFont.familyNames
    {
        print("\(family)")
        for names: String in UIFont.fontNames(forFamilyName: family)
        {
            print("== \(names)")
        }
    }
}
