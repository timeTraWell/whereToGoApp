//
//  ViewController.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 18/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var adapter: MainTableViewAdapter?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let service = EventsService()
        service.loadEvents(eventsCount: "5") { (result) in
            switch result {
            case .data(let events):
                self.setupAdapter(events: events)
            case .error(let error):
                print(error)
            }
        }
        
    }

    // MARK: - Private helpers

    private func setupAdapter(events: [Event]) {
        let adapter = MainTableViewAdapter(events: events, tableView: tableView)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.reloadData()
        self.adapter = adapter
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
}

