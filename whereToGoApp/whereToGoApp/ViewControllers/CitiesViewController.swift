//
//  CitiesViewController.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class CitiesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var citiesTableView: UITableView!
    @IBOutlet private weak var loadingIndicatorContainer: UIView!
    
    // MARK: - Properties
    
    private var adapter: CitiesTableViewAdapter?
    private var cities: [City]?
    
    weak var delegate: EventsOutputProtocol?

    // MARK: - Init

    init?(delegate: EventsOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadContent()
    }
    
    // MARK: - Private helpers
    
    private func setupTableView() {
        citiesTableView.tableFooterView = UIView()
        citiesTableView.allowsSelection = true
        citiesTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func loadContent() {
        let place = PlaceService()
        place.loadCities(completion: { (result) in
            switch result {
                case .data(let cities):
                    self.loadingIndicatorContainer.isHidden = true
                    self.cities = cities
                    self.setupAdapter(cities: cities)
                case .error(let error):
                    print(error)
                    self.toEventsScreen()
                }
        })
    }
    
    private func setupAdapter(cities: [City]) {
        let adapter = CitiesTableViewAdapter(cities: cities, tableView: self.citiesTableView)
        adapter.didSelectItem = { [weak self] index in
            guard let cities = self?.cities else {
                return
            }
            self?.saveChosenCity(cityName: cities[index].name, citySlug: cities[index].slug)
            self?.delegate?.didCityChange(name: cities[index].name, slug: cities[index].slug)
            self?.toEventsScreen()
        }
        
        citiesTableView.separatorStyle = .none
        citiesTableView.dataSource = adapter
        citiesTableView.delegate = adapter
        citiesTableView.reloadData()
        self.adapter = adapter
    }
    
    private func toEventsScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func saveChosenCity(cityName: String, citySlug: String) {
        let chosenCity = City(name: cityName, slug: citySlug)
        let _ = FileService().saveToFile(city: chosenCity)
    }

}
