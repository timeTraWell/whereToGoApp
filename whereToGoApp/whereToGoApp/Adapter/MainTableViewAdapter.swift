//
//  MainTableViewAdapter.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class MainTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK:- Properties

    private var placesToGo: [String]
    private let titleCellName = String(describing: TitleCell.self)
    private let navCellName = String(describing: NavigationCell.self)
    private let contentCell = String(describing: ContentCell.self)

    // MARK: - Init

    init(numberOfCells: [String], tableView: UITableView) {
        self.placesToGo = numberOfCells
        tableView.register(
            UINib(nibName: titleCellName, bundle: .main),
            forCellReuseIdentifier: titleCellName
        )
        tableView.register(
            UINib(nibName: navCellName, bundle: .main),
            forCellReuseIdentifier: navCellName
        )
        tableView.register(
            UINib(nibName: contentCell, bundle: .main),
            forCellReuseIdentifier: contentCell
        )
    }

    // MARK: - UITableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2 + placesToGo.count
        return 2 + 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: navCellName, for: indexPath) as? NavigationCell else {
                    fatalError("re")
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: titleCellName, for: indexPath) as? TitleCell else {
                    fatalError("kek")
                }
            cell.titleLabel.text = "Куда сходить"
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: contentCell, for: indexPath) as? ContentCell else {
                    fatalError("keks")
                }
            return cell
        }
    }
}
