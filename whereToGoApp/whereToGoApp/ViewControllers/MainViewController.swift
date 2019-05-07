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
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var navButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    
    // MARK: - IBOutlets constraint
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topLogoMargin: NSLayoutConstraint!
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLogoMargin: NSLayoutConstraint!
    
    
    // MARK: - Properties
    
    private var adapter: EventsTableViewAdapter?
    private let refreshControl = UIRefreshControl()
    private let topViewHeightConst = CGFloat(80)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupTableView()
        setupRefreshControl()
        setupNavButton()
        loadContent()
        
    }
    
    private func loadContent() {
        let service = EventsService()
        service.loadEvents(eventsCount: "20") { (result) in
            switch result {
            case .data(let events):
                self.setupAdapter(events: events)
            case .error(let error):
                self.showInternetConnectionError()
                print(error)
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction func onPressNavButton(_ sender: Any) {
        print("nav button pressed")
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

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refreshTarget), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func refreshTarget() {
        let loadingTime: Double = 5.5
        let dispatchTime: DispatchTime = .now() + loadingTime
        DispatchQueue.main.asyncAfter(deadline: dispatchTime ) {
            self.loadContent()
            self.refreshControl.endRefreshing()
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
        let adapter = EventsTableViewAdapter(events: events, main: self, tableView: tableView)
        adapter.scrollContentIsOverTop = { [weak self] yPosition in
            guard let vc = self else { return }
            if yPosition < 10 {
                
                vc.modifyNavigationView()
            }
            if yPosition == 0 {
                
                vc.setNavigationViewToOriginal()
            }
        }
        tableView.dataSource = adapter
        tableView.delegate = adapter
        loaderView.isHidden = true
        tableView.reloadData()
        self.adapter = adapter
    }
    
    private func modifyNavigationView() {
        navigationView.backgroundColor = Color.blurWhite
        
        //add blur
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = navigationView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navigationView.insertSubview(blurEffectView, at: 0)
        
        //change elements and constraints in root view
        logo.image = UIImage(named: "logoScroll")
        topLogoMargin.constant = 26
        logoHeight.constant = 32
        bottomLogoMargin.constant = 6
        
    }
    
    private func setNavigationViewToOriginal() {
        navigationView.backgroundColor = Color.white
        
        for subview in navigationView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        logo.image = UIImage(named: "logoBig")
        topLogoMargin.constant = 36
        logoHeight.constant = 44
        bottomLogoMargin.constant = 0
    }
    
    private func setupNavButton() {
        navButton.titleLabel?.font = Fonts.getFont(fontName: "SFProText-Semibold", size: 17)
        navButton.setTitleColor(Color.navOrange, for: .normal)
        navButton.setTitle("Москва", for: .normal)
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
}

