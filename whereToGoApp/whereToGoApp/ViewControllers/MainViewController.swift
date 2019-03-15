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
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var internetErrorConectionView: UIView!
    @IBOutlet weak var errorMessageView: UIView!
    @IBOutlet weak var errorDescriptorLabel: UILabel!
    
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
//                fatalError("inetKEK")
                self.showInternetConnectionError()
                print(error)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let eventData = sender as? Event else {
            print("cast error")
            return
        }
        
        switch (segue.identifier ?? "") {
        
            case "showDetail":
                guard let detailEventViewController = segue.destination as? DetailEventViewController else {
                    print("segue destination \(segue.destination) error")
                    return
                }
                detailEventViewController.setEvent(event: eventData)
            default:
                return
        }
    }

    // MARK: - Private helpers

    private func setupAdapter(events: [Event]) {
        let adapter = MainTableViewAdapter(events: events, main: self, tableView: tableView)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        loaderView.isHidden = true
        tableView.reloadData()
        self.adapter = adapter
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    private func showInternetConnectionError() {
        errorMessageView.backgroundColor = Color.errorRed
        
        errorLabel.font = Fonts.SFProText16Reg
        errorLabel.textColor = Color.white
        errorLabel.text = "Невозможно загрузить данные, проверьте соединение с интернетом"
        
        errorDescriptorLabel.font = Fonts.SFProText14
        errorDescriptorLabel.textColor = Color.black
        errorDescriptorLabel.text = "Ошибка загрузки данных, проверьте соединение с интернетом"
        
        loaderView.isHidden = true
        internetErrorConectionView.isHidden = false
    }
    
}
