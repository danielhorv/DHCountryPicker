//
//  ViewController.swift
//  DHCountryPickerExample
//
//  Created by Daniel Horvath on 30.12.19.
//  Copyright © 2019 Daniel Horvath. All rights reserved.
//

import UIKit
import DHCountryPicker

class ViewController: UIViewController {

    private let containerStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 10
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let openPickerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Show CountryPicker", for: .normal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        return $0
    }(UIButton(type: .system))
    
    private let countryInfosStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let selectedCountryLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        return $0
    }(UILabel())
    
    private let selectedCountryFlagImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIImageView())
    
    private let countryProvider = DHCountryProvider()
    
    var selectedCountry: Country? {
        didSet {
            updateCountryInfos(with: selectedCountry)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        countryInfosStackView.addArrangedSubview(selectedCountryFlagImageView)
        countryInfosStackView.addArrangedSubview(selectedCountryLabel)
        containerStackView.addArrangedSubview(countryInfosStackView)
        containerStackView.addArrangedSubview(openPickerButton)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([containerStackView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                                     containerStackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)])
        
        openPickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        
        selectedCountry = countryProvider.current
    }

    @objc private func showPicker() {
        let countryPickerViewController = DHCountryPickerViewController(selectedCountry: selectedCountry)
        countryPickerViewController.delegate = self
        countryPickerViewController.isDialCodeHidden = false
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: countryPickerViewController, action: #selector(countryPickerViewController.dismissAnimated))
        countryPickerViewController.navigationItem.rightBarButtonItem = closeButton
        
        present(UINavigationController(rootViewController: countryPickerViewController), animated: true, completion: nil)
    }
    
    private func updateCountryInfos(with country: Country?) {
        selectedCountryFlagImageView.image = country?.flag
        selectedCountryLabel.text = country?.localizedName
    }
}

extension ViewController: DHCountryPickerDelegate {
    func countryPickerViewController(_ countryPickerViewController: DHCountryPickerViewController, selectedCountry country: Country) {
        self.selectedCountry = country
    }
}
