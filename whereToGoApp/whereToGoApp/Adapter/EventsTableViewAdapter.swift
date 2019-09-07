//
//  MainTableViewAdapter.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class EventsTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Properties
    private let titleCellName = String(describing: TitleCell.self)
    private let contentCell = String(describing: ContentCell.self)
    private let events: [Event]
    var scrollContentIsOverTop: ((CGFloat) -> Void)?
    var didSelectItem: ( (Int) -> Void )?
    private let fixedContentCells = 1

    //MARK: - Init
    init(events: [Event], tableView: UITableView) {
        self.events = events
        tableView.register(
            UINib(nibName: titleCellName, bundle: .main),
            forCellReuseIdentifier: titleCellName
        )
        tableView.register(
            UINib(nibName: contentCell, bundle: .main),
            forCellReuseIdentifier: contentCell
        )
    }

    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixedContentCells + events.count
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
            cell.setupCell(event: events[indexPath.row - fixedContentCells])
            return cell
        }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row > (fixedContentCells - 1) {
            didSelectItem?(indexPath.row - fixedContentCells)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            scrollContentIsOverTop?(scrollView.contentOffset.y)
        }
    }
}
