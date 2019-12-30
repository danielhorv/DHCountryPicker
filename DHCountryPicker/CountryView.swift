//
//  CountryView.swift
//  DHCountryPicker
//
//  Created by Daniel Horvath on 13.11.19.
//  Copyright © 2019 Daniel Horvath. All rights reserved.
//

import UIKit

class CountryView: UIView {

    private let containerStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let countryNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let flagImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: Country) {
        flagImageView.isHidden = country.flag == nil
        flagImageView.image = country.flag
        countryNameLabel.text = country.localizedName
    }
    
    private func setupView() {
        directionalLayoutMargins = .zero
        containerStackView.addArrangedSubview(flagImageView)
        containerStackView.addArrangedSubview(countryNameLabel)
        
        addSubview(containerStackView)
        
        NSLayoutConstraint.activate([containerStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     containerStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                                     containerStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                                     containerStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)])
    }
}
