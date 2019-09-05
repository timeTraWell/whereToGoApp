//
//  CitiesViewController.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var citiesTableView: UITableView!
    
    //MARK:- Properties
    private var adapter: CitiesTableViewAdapter?
    private var cities: [City]?

    //MARK:- ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContent()
    }
    
    //MARK:- Private helpers
    private func loadContent() {
        let place = PlaceService()
        place.loadCities(completion: { (result) in
            switch result {
                case .data(let cities):
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
            print("name: \(cities[index].name), slug \(cities[index].slug)")
            self?.toEventsScreen()
        }
        
        citiesTableView.separatorStyle = .none
        citiesTableView.dataSource = adapter
        citiesTableView.delegate = adapter
        citiesTableView.reloadData()
        self.adapter = adapter
    }
    
    private func toEventsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let eventsScreen = storyboard.instantiateViewController(withIdentifier: "EventsScreen") as? EventsViewController else {
            return
        }
        self.navigationController?.pushViewController(eventsScreen, animated: true)
    }

}
