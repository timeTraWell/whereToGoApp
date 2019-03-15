//
//  DetailEventViewController.swift
//  
//
//  Created by Nickolay Nickitin on 10/03/2019.
//

import UIKit
import MapKit

class DetailEventViewController: UIViewController {
    
    // MARK: - Properties
    
    private var event: Event?
    
    // MARK: - IBOutlets
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Labels
    @IBOutlet weak var eventHeaderLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDetailLabel: UILabel!
    @IBOutlet weak var eventGeoLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventCostLabel: UILabel!
    
    @IBOutlet weak var geoIcon: UIImageView!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    // MARK: - IBActions
    
    @IBAction func buttonBackTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMain", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBack()
        setupContent()
        
//        print(self.eventID)
        // Do any additional setup after loading the view.
    }
    
    public func setEvent(event: Event) {
        self.event = event
    }
    
    
    // MARK: - Private helpers
    
    private func setupContent() {
        eventHeaderLabel.font = Fonts.SFProText20
        eventHeaderLabel.textColor = Color.black
        let eventName = castToString(data: event?.title)
        eventHeaderLabel.text = eventName
        
        eventDescriptionLabel.font = Fonts.SFProTextSemibold
        eventDescriptionLabel.textColor = Color.black
        let eventDescription = castToString(data: event?.description)
        eventDescriptionLabel.text = eventDescription
        
        eventDetailLabel.font = Fonts.SFProText16Reg
        eventDetailLabel.textColor = Color.gray
        let eventDetail = castToString(data: event?.body_text)
        eventDetailLabel.text = eventDetail
        
        initSubLabels(subLabel: eventGeoLabel)
        initSubLabels(subLabel: eventDateLabel)
        initSubLabels(subLabel: eventCostLabel)
        
        let geo = castToString(data: event?.place?.address)
        if geo != "" {
            eventGeoLabel.text = geo
        } else {
            eventGeoLabel.isHidden = true
            geoIcon.isHidden = true
        }
        
        let price = castToString(data: event?.price)
        if price == "" { // TODO: - perform ternar operatop
            eventCostLabel.text = "бесплатно"
        } else {
            eventCostLabel.text = price
        }
        
        guard let date = event?.dates?[0] else {
            print("date cast error")
            return
        }
        
        let startDate = DateParser.getFormatedDate(intDate: date.start)
        let endDate = DateParser.getFormatedDate(intDate: date.end)
        
        if (startDate != "error" && endDate != "error") {
            eventDateLabel.text = startDate + " - " + endDate
        } else {
            print("start or end dataKekys")
        }
    }
    
    private func castToString(data: String?) -> String {
        guard let resultData = data else {
            return ""
        }
        return resultData
    }
    
    private func castToInt(value: Int?) -> Int {
        guard let resultValue = value else {
            return 0
        }
        return resultValue
    }
    
    private func initSubLabels(subLabel: UILabel) {
        subLabel.font = Fonts.getFont(fontName: "SFProText-Regular", size: 14)
        subLabel.textColor = Color.gray
    }
    
    private func setupButtonBack() {
        buttonBack.backgroundColor = Color.white
        buttonBack.layer.cornerRadius = 16
    }

}
