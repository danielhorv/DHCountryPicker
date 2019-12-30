//
//  CountryCell.swift
//  DHCountryPicker
//
//  Created by Daniel Horvath on 13.11.19.
//  Copyright © 2019 Daniel Horvath. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    private let contentViewMargins = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
    
    let countryView: CountryView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CountryView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if #available(iOS 13.0, *) {
            tintColor = .label
        } 
        
        contentView.directionalLayoutMargins = contentViewMargins
        contentView.addSubview(countryView)
        
        NSLayoutConstraint.activate([countryView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
                                     countryView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                                     countryView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
                                     countryView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
