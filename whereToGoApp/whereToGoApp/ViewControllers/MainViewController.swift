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
        setupAdapter()
    }

    // MARK: - Private helpers

    private func setupAdapter() {
        let adapter = MainTableViewAdapter(numberOfCells: [], tableView: tableView)
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

