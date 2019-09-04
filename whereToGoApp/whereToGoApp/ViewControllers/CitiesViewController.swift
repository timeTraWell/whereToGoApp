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
                    self.setupAdapter(cities: cities)
                case .error(let error):
                    //TODO:- perform return to main screen
                    print(error)
                }
        })
    }
    
    private func setupAdapter(cities: [City]) {
        let adapter = CitiesTableViewAdapter(cities: cities, tableView: self.citiesTableView)
        citiesTableView.separatorStyle = .none
        citiesTableView.dataSource = adapter
        citiesTableView.delegate = adapter
        citiesTableView.reloadData()
        self.adapter = adapter
    }

}
