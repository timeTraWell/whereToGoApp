//
//  CitiesTableViewAdapter.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class CitiesTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Properties
    private let cities: [City]
    private let cityCell = String(describing: CityCell.self)
    
    init(cities: [City], tableView: UITableView) {
        self.cities = cities
        tableView.register(
            UINib(nibName: cityCell, bundle: .main),
            forCellReuseIdentifier: cityCell
        )
    }
    
    //MARK:- tableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cityCell, for: indexPath) as? CityCell else {
            return UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier: cityCell)
        }
        cell.setupCell(city: cities[indexPath.row].name)
        return cell
    }
}
