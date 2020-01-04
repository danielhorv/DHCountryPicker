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

    private let openPickerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Open CountryPicker", for: .normal)
        return $0
    }(UIButton(type: .system))
    
    private let countryProvider = DHCountryProvider()
    
    var selectedCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(openPickerButton)
        
        NSLayoutConstraint.activate([openPickerButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                                     openPickerButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)])
        
        openPickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        
        selectedCountry = countryProvider.current
    }

    @objc private func showPicker() {
        let countryPickerViewController = CountryPickerViewController(selectedCountry: selectedCountry, countries: countryProvider.availableCountries)
        countryPickerViewController.delegate = self
        present(UINavigationController(rootViewController: countryPickerViewController), animated: true, completion: nil)
    }
}

extension ViewController: CountryPickerDelegate {
    func countryPickerViewController(_ countryPickerViewController: CountryPickerViewController, selectedCountry country: Country) {
        self.selectedCountry = country
    }
}
