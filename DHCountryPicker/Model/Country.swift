//
//  Country.swift
//  DHCountryPicker
//
//  Created by Daniel Horvath on 13.11.19.
//  Copyright © 2019 Daniel Horvath. All rights reserved.
//

import Foundation
import FlagKit

public struct Country: Codable, Equatable {
    public let regionCode: String
    public let dialCode: String
    
    private enum CodingKeys: String, CodingKey {
        case regionCode = "code"
        case dialCode = "dial_code"
    }
}

public extension Country {
    var localizedName: String {
        return Locale.current.localizedString(forRegionCode: regionCode) ?? ""
    }
    
    var flag: UIImage? {
        return Flag(countryCode: regionCode)?.image(style: .none)
    }
}
