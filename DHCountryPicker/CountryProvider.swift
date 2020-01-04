//
//  CountryProvider.swift
//  DHCountryPicker
//
//  Created by Daniel Horvath on 13.11.19.
//  Copyright © 2019 Daniel Horvath. All rights reserved.
//

import Foundation

public protocol CountryProvider {
    var availableCountries: [Country] { get }
    var current: Country? { get }
 }

private class ResourceHelper { }

fileprivate enum FileExtension: String {
    case json
}

fileprivate enum Resource: String {
    case countryCodes = "countryCodes"
    
    var url: URL? {
        let bundle = Bundle(for: ResourceHelper.self)
        
        switch self {
        case .countryCodes:
            return bundle.url(forResource: self.rawValue, withExtension: FileExtension.json.rawValue)
        }
    }
}

public class DHCountryProvider: CountryProvider {
    
    public var availableCountries: [Country] = []
    
    public init() {
        guard let countryCodesJson = Resource.countryCodes.url else { return }
        
        do {
            let data = try Data(contentsOf: countryCodesJson)
            let jsonDecoder = JSONDecoder()
            availableCountries = try jsonDecoder.decode([Country].self, from: data)
                .sorted { $0.localizedName < $1.localizedName }
        } catch {
            print(error)
        }
    }
    
    public var current: Country? {
        return availableCountries.first(where: { $0.regionCode.lowercased() == Locale.current.regionCode?.lowercased() })
    }
}
