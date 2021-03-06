//
//  ContentCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 26/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit
import AlamofireImage

final class ContentCell: UITableViewCell {

    // MARK :- IBOutlets
    
    @IBOutlet private weak var topImage: UIImageView!
    @IBOutlet private weak var eventNameLabel: UILabel!
    @IBOutlet private weak var eventDescriptionLabel: UILabel!
    @IBOutlet private weak var geoLocationLabel: UILabel!
    @IBOutlet private weak var eventDateLabel: UILabel!
    @IBOutlet private weak var eventCostLabel: UILabel!
    @IBOutlet private weak var geoView: UIView!
    @IBOutlet private weak var container: UIView!

    // MARK:- UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        initLabels()
        initContainer()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        topImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }

    // MARK: - Internal helpers
    
    func setupCell(event: Event) {
        eventNameLabel.text = event.title
        eventDescriptionLabel.text = event.description
        eventCostLabel.text = (event.price == "" ? "бесплатно" : event.price)
        
        guard let dates = event.dates, !dates.isEmpty else {
            return
        }
        
        let date = dates[0]
        
        guard let startDate = DateParser.getFormatedDate(intDate: date.start),
            let endDate = DateParser.getFormatedDate(intDate: date.end) else {
                return
        }
        eventDateLabel.text = startDate + " - " + endDate
        
        topImage.layer.masksToBounds = true
        topImage.layer.cornerRadius = 12
        topImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if !event.images.isEmpty,
            let imageURL = URL(string: event.images[0].image),
            let placeholder = UIImage(named: "defaultImg") {
            //set image automatically when download compelete.
            self.topImage.af_setImage(withURL: imageURL, placeholderImage: placeholder)
        }
        
        if event.place?.address != nil {
            geoView.isHidden = false
            geoLocationLabel.text = event.place?.address
        } else {
            geoView.isHidden = true
        }
    }
    
    // MARK: - Private helpers
    
    private func initLabels()  {
        eventNameLabel.font = Fonts.getFont(fontName: "SFProText-Bold", size: 16)
        eventNameLabel.textColor = Color.black
        
        eventDescriptionLabel.font = Fonts.getFont(fontName: "SFProText-Regular", size: 14)
        eventDescriptionLabel.textColor = Color.black
        
        setupDetailEventLabels(label: geoLocationLabel)
        setupDetailEventLabels(label: eventDateLabel)
        setupDetailEventLabels(label: eventCostLabel)
    }
    
    private func setupDetailEventLabels(label: UILabel) {
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
