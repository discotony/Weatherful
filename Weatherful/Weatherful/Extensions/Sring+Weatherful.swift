//
//  Sring+Weatherful.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/21/23.
//

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
