//
//  MainTableViewAdapter.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class EventsTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK:- Properties

    private let titleCellName = String(describing: TitleCell.self)
    private let contentCell = String(describing: ContentCell.self)
    private let events: [Event]
    private let main: EventsViewController
    var scrollContentIsOverTop: ((CGFloat) -> Void)?
    
    private let countOfIBCells = 1

    // MARK: - Init

    init(events: [Event], main: EventsViewController, tableView: UITableView) {
        self.events = events
        self.main = main
        tableView.register(
            UINib(nibName: titleCellName, bundle: .main),
            forCellReuseIdentifier: titleCellName
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
        return countOfIBCells + events.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row > (countOfIBCells - 1) {
            self.main.performSegue(withIdentifier: "showDetail", sender: events[indexPath.row - countOfIBCells])
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: titleCellName, for: indexPath) as? TitleCell else {
                return UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier:titleCellName)
                }
            cell.titleLabel.text = "Куда сходить"
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: contentCell, for: indexPath) as? ContentCell else {
                    return UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier:contentCell)
                }
            cell.setupCell(event: events[indexPath.row - countOfIBCells])
            return cell
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            scrollContentIsOverTop?(scrollView.contentOffset.y)
        }
    }
}
