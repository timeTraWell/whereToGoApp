//
//  DetailEventViewController.swift
//  
//
//  Created by Nickolay Nickitin on 10/03/2019.
//

import UIKit
import MapKit

class DetailEventViewController: UIViewController {
    
    //MARK:- Properties
    
    private var event: Event?
    private var adapter: ImageCollectionViewAdapter?
    
    //MARK:- IBOutlets
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- IBOutlets, labels
    
    @IBOutlet weak var eventHeaderLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDetailLabel: UILabel!
    @IBOutlet weak var eventGeoLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventCostLabel: UILabel!
    
    @IBOutlet weak var geoView: UIView!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    //MARK:- IBAction
    
    @IBAction func buttonBackTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBack()
        setupAdapter()
        setupContent()
    }
    
    //MARK:- Public method
    
    public func setEvent(event: Event) {
        self.event = event
    }
    
    
    //MARK:- Private helpers
    
    private func setupAdapter() {
        guard let images = event?.images else {
            return
        }
        pageControl.numberOfPages = images.count
        let adapter = ImageCollectionViewAdapter(collectionView: imageCollectionView, images: images, imageControl: pageControl)
        imageCollectionView.delegate = adapter
        imageCollectionView.dataSource = adapter
        imageCollectionView.reloadData()
        self.adapter = adapter
    }
    
    private func setupContent() {
        let lat = event?.place?.coords.lat ?? 55.7522200
        let lon = event?.place?.coords.lon ?? 37.6155600 // msk coords
        setupMap(latitude: lat, longitude: lon)
        
        setupEventHeaderLabel(label: eventHeaderLabel)
        setupEventDescriptionLabel(label: eventDescriptionLabel)
        setupEventDetailLabel(label: eventDetailLabel)
        
        setupDetailEventLabels(label: eventGeoLabel)
        setupDetailEventLabels(label: eventDateLabel)
        setupDetailEventLabels(label: eventCostLabel)
        
        let geo = castToString(data: event?.place?.address)
        if geo != "" {
            eventGeoLabel.text = geo
        } else {
            geoView.isHidden = true
        }
        
        let price = castToString(data: event?.price)
        eventCostLabel.text = (price == "" ? "бесплатно" : price)
        
        guard let dates = event?.dates, !dates.isEmpty else {
            return
        }
        let date = dates[0]
        guard let startDate = DateParser.getFormatedDate(intDate: date.start) else {
            return
        }
        guard let endDate = DateParser.getFormatedDate(intDate: date.end) else {
            return
        }
        eventDateLabel.text = startDate + " - " + endDate
    }
    
    private func setupEventHeaderLabel(label: UILabel) {
        label.font = Fonts.getFont(fontName: "SFProText-Bold", size: 20)
        label.textColor = Color.black
        let eventName = castToString(data: event?.title)
        label.text = eventName
    }
    
    private func setupEventDescriptionLabel(label: UILabel) {
        label.font = Fonts.getFont(fontName: "SFProText-Semibold", size: 16)
        label.textColor = Color.black
        let eventDescription = castToString(data: event?.description)
        label.text = eventDescription
    }
    
    private func setupEventDetailLabel(label: UILabel) {
        label.font = Fonts.getFont(fontName: "SFProText-Regular", size: 16)
        label.textColor = Color.gray
        let eventDetail = castToString(data: event?.body_text)
        label.text = eventDetail
    }
    
    private func castToString(data: String?) -> String {
        guard let resultData = data else {
            return ""
        }
        return resultData
    }
    
    private func setupMap(latitude: Double, longitude: Double) {
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 1000
        centerMapOnLocation(location: initialLocation, regionRadius: regionRadius)
    }
    
    private func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    private func setupDetailEventLabels(label: UILabel) {
        label.font = Fonts.getFont(fontName: "SFProText-Regular", size: 14)
        label.textColor = Color.gray
    }
    
    private func setupButtonBack() {
        buttonBack.backgroundColor = Color.white
        buttonBack.layer.cornerRadius = 16
    }

}
