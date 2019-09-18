//
//  ViewController.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 18/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class EventsViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var internetErrorConectionView: UIView!
    @IBOutlet weak var errorMessageView: UIView!
    @IBOutlet weak var errorDescriptorLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var navButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    
    //MARK:- IBOutlets constraint
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topLogoMargin: NSLayoutConstraint!
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLogoMargin: NSLayoutConstraint!
    
    
    //MARK:- Properties
    private var adapter: EventsTableViewAdapter?
    private let refreshControl = UIRefreshControl()
    private let topViewHeightConst = CGFloat(80)
    private var events: [Event]?
    private var city: City?
    private var eventsCount = 20
    private var page = 1

    //MARK:- UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupTableView()
        setupRefreshControl()
        loadCity()
        setupNavButton()
        loadContent(eventsCount: eventsCount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if refreshControl.isRefreshing {
            let contentOffSet = tableView.contentOffset
            refreshControl.endRefreshing()
            refreshControl.beginRefreshing()
            tableView.contentOffset = contentOffSet
        }
    }
    
    //MARK:- IBAction
    @IBAction func onPressNavButton(_ sender: Any) {
        let citiesViewController = CitiesViewController(eventsViewController: self)
        self.navigationController?.pushViewController(citiesViewController, animated: true)
    }
    
    //MARK:- Private helpers
    private func setupAdapter(events: [Event]) {
        let adapter = EventsTableViewAdapter(events: events, tableView: tableView)
        adapter.scrollContentIsOverTop = { [weak self] yPosition in
            guard let vc = self else { return }
            
            let countedContentHeight = vc.eventsCount * 400
            
            if (countedContentHeight / 2) < Int(yPosition) {
                guard let a = vc.adapter else {
                    return
                }
                vc.page += 1
                vc.loadAdditionalContent(eventsCount: 20, page: vc.page, adapter: a)
                vc.eventsCount += 20
            }
        }
        
        adapter.didSelectItem = { [weak self] index in
            guard let events = self?.events else {
                return
            }
            self?.performSegue(withIdentifier: "showDetail", sender: events[index])
        }
        
        tableView.dataSource = adapter
        tableView.delegate = adapter
        loaderView.isHidden = true
        tableView.reloadData()
        self.adapter = adapter
    }
    
    private func loadAdditionalContent(eventsCount: Int, page: Int, adapter: EventsTableViewAdapter) {
        let service = EventsService()
        let citySlug = self.city?.slug ?? "msk"
        service.loadEvents(eventsCount: eventsCount, page: page, citySlug: citySlug) { (result) in
            switch result {
            case .data(let events):
                guard var currentEvents = self.events else { return }
                currentEvents += events
                self.events = currentEvents
                adapter.addNewEvents(events: events)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func loadContent(eventsCount: Int) {
        let service = EventsService()
        let citySlug = self.city?.slug ?? "msk"
        service.loadEvents(eventsCount: eventsCount, page: self.page, citySlug: citySlug) { (result) in
            switch result {
            case .data(let events):
                self.events = events
                self.setupAdapter(events: events)
            case .error(let error):
                self.showInternetConnectionError()
                print(error)
            }
        }
    }
    
    private func loadCity() {
        let file = FileService()
        if file.loadFromFile() == nil {
            self.city = City(name: "Москва", slug: "msk")
        } else {
            self.city = file.loadFromFile()
        }
    }
    
    @objc private func refreshTarget() {
        let loadingTime: Double = 5.5
        let dispatchTime: DispatchTime = .now() + loadingTime
        DispatchQueue.main.asyncAfter(deadline: dispatchTime ) {
            //Back to initial values
            self.eventsCount = 20
            self.page = 1
            self.loadContent(eventsCount: self.eventsCount)
            self.refreshControl.endRefreshing()
        }
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refreshTarget), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupNavButton() {
        navButton.titleLabel?.font = Fonts.getFont(fontName: "SFProText-Semibold", size: 17)
        navButton.setTitleColor(Color.navOrange, for: .normal)
        
        let cityName = self.city?.name
        navButton.setTitle(cityName, for: .normal)
        navButton.centerTextAndImage(spacing: -6)
        
        navButton.tintColor = Color.navOrange
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
        
        errorLabel.font = Fonts.getFont(fontName: "SFProText-Regular", size: 16)
        errorLabel.textColor = Color.white
        errorLabel.text = "Невозможно загрузить данные, проверьте соединение с интернетом"
        
        errorDescriptorLabel.font = Fonts.getFont(fontName: "SFProText-Regular", size: 14)
        errorDescriptorLabel.textColor = Color.black
        errorDescriptorLabel.text = "Ошибка загрузки данных, проверьте соединение с интернетом"
        
        loaderView.isHidden = true
        internetErrorConectionView.isHidden = false
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let eventData = sender as? Event else {
            return
        }
        
        switch (segue.identifier ?? "") {
            case "showDetail":
                guard let detailEventViewController = segue.destination as? DetailEventViewController else {
                    return
                }
                detailEventViewController.setEvent(event: eventData)
            default:
                return
        }
    }
    
}

extension EventsViewController: EventsOutputProtocol {
    func didCityChanged(name: String, slug: String) {
        self.city = City(name: name, slug: slug)
        tableView.contentOffset.y = 0
        setupNavButton()
        self.eventsCount = 20
        self.page = 1
        loadContent(eventsCount: eventsCount)
    }
}
