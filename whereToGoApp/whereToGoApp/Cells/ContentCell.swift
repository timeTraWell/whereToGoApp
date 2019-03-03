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
        initLabels()
        initContainer()
    }
    
    private func initLabels()  {
        eventNameLabel.font = Fonts.SFProText16
        eventNameLabel.textColor = Color.black
        
        eventDescriptionLabel.font = Fonts.SFProText14
        eventDescriptionLabel.textColor = Color.black
        
        geoLocationLabel.font = Fonts.SFProText14
        geoLocationLabel.textColor = Color.gray
        
        eventDateLabel.font = Fonts.SFProText14
        eventDateLabel.textColor = Color.gray
        
        eventCostLabel.font = Fonts.SFProText14
        eventCostLabel.textColor = Color.gray
    }
    
    private func initContainer()    {
        container.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        container.layer.cornerRadius = 16
        
        container.layer.masksToBounds = false
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 12
        container.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15).cgColor
        container.layer.shadowOpacity = 1
    }
    
}
