//
//  CountryPickerViewController.swift
//  DHCountryPicker
//
//  Created by Daniel Horvath on 13.11.19.
//  Copyright © 2019 Daniel Horvath. All rights reserved.
//

import UIKit

public protocol DHCountryPickerDelegate: class {
    func countryPickerViewController(_ countryPickerViewController: DHCountryPickerViewController, selectedCountry country: Country)
}

public class DHCountryPickerViewController: UIViewController {
    
    private struct Section {
        let letter: String
        let countries: [Country]
    }
    
    private let cellIdentifier: String = "CountryCellId"
    
    private var selectedCountry: Country?
    
    private let countryProvider: CountryProvider
    
    private var sections: [Section] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var autoDismissOnSelect: Bool = true
    
    public var isDialCodeHidden: Bool = true
    
    public weak var delegate: DHCountryPickerDelegate?
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView()
        $0.register(CountryCell.self, forCellReuseIdentifier: cellIdentifier)
        $0.tintColor = .black
        $0.keyboardDismissMode = .onDrag
        return $0
    }(UITableView())
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    public init(selectedCountry: Country? = nil, provider: CountryProvider = DHCountryProvider()) {
        self.selectedCountry = selectedCountry
        self.countryProvider = provider
        super.init(nibName: nil, bundle: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchResultsUpdater = self
        sections = generateSections(for: countryProvider.availableCountries)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        searchController.isActive = false
        searchController.searchBar.resignFirstResponder()
        super.dismiss(animated: flag, completion: completion)
    }
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            tableView.sectionIndexColor = .label
            navigationController?.navigationBar.backgroundColor = .secondarySystemGroupedBackground
        } else {
            view.backgroundColor = .white
            navigationController?.navigationBar.backgroundColor = .white
        }
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func generateSections(for countries: [Country]) -> [Section] {
        let groupedDictionary = Dictionary(grouping: countries, by: { String($0.localizedName.prefix(1)) })
        // get the keys and sort them
        let keys = groupedDictionary.keys.sorted()
        // map the sorted keys to a struct
        return keys.map { Section(letter: $0, countries: groupedDictionary[$0]!) }
    }
    
    @objc public func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc public func dismissNonAnimated() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + view.layoutMargins.bottom, right: 0)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = .zero
     }
}

extension DHCountryPickerViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].countries.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = sections[indexPath.section].countries[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CountryCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: country, isDialCodeHidden: isDialCodeHidden)
        cell.accessoryType = selectedCountry == country ? .checkmark : .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = sections[indexPath.section].countries[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.countryPickerViewController(self, selectedCountry: selectedCountry)
        
        if autoDismissOnSelect {
            dismiss(animated: true)
        }
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map { $0.letter }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
}

extension DHCountryPickerViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let userInput = searchController.searchBar.text else {
            return
        }
        
        if !userInput.isEmpty {
            let filteredCountries = countryProvider.availableCountries
                .filter { $0.localizedName.lowercased().starts(with: userInput.trimmingCharacters(in: .whitespaces).lowercased()) }
            
            sections = generateSections(for: filteredCountries)
        } else {
            sections = generateSections(for: countryProvider.availableCountries)
        }
    }
}
