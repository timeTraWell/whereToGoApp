//
//  ContentCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 26/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var geoLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventCostLabel: UILabel!
    @IBOutlet weak var geoIcon: UIImageView!
    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var costIcon: UIImageView!
    @IBOutlet weak var container: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
        initLabels()
        initContainer()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }

    func setupCell(event: Event) {
        eventNameLabel.text = event.title
        eventDescriptionLabel.text = event.description
        
        if event.price == "" { // TODO: - perform ternar operatop
            eventCostLabel.text = "бесплатно"
        } else {
            eventCostLabel.text = event.price
        }
        
        guard let date = event.dates?[0] else {
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
        
        topImage.layer.masksToBounds = true
        topImage.layer.cornerRadius = 12
        topImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let imgService = ImagesLoader()
        imgService.getImage(event.images[0].image) { (image) in
            if let imageURL = URL(string: event.images[0].image), let placeholder = UIImage(named: "defaultImg") {
                self.topImage.af_setImage(withURL: imageURL, placeholderImage: placeholder) //set image automatically when download compelete.
            }
        }
        
        if ( event.place?.address != nil)   {
            geoLocationLabel.text = event.place?.address
        } else {
            geoLocationLabel.isHidden = true
            geoIcon.isHidden = true
        }
        
    }
    
    private func initLabels()  {
        eventNameLabel.font = Fonts.SFProText16
        eventNameLabel.textColor = Color.black
        
        eventDescriptionLabel.font = Fonts.SFProText14
        eventDescriptionLabel.textColor = Color.black
        
        initSubLabels(label: geoLocationLabel)
        initSubLabels(label: eventDateLabel)
        initSubLabels(label: eventCostLabel)
    }
    
    private func initSubLabels(label: UILabel) {
        label.font = Fonts.getFont(fontName: "SFProText-Regular", size: 14)
        label.textColor = Color.gray
    }
    
    private func initContainer() {
        container.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        container.layer.cornerRadius = 16
        
        container.layer.masksToBounds = false
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 12
        container.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15).cgColor
        container.layer.shadowOpacity = 1
    }
    
}
