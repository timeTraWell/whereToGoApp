//
//  CityCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet weak var cityNameLabel: UILabel!    
    @IBOutlet weak var container: UIView!
    
    //MARK:- Properties
    private var cityName: String?
    private var citySlug: String?
    
    //MARK:- TableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initContainer()
        cityNameLabel.font = Fonts.getFont(fontName: "SFProText-Bold", size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
    
    //MARK:- Setup func
    func setupCell() {
        cityNameLabel.text = self.cityName
    }
    
    func setData(name: String, slug: String) {
        self.cityName = name
        self.citySlug = slug
    }
    
    //MARK:- Private helper
    private func initContainer() {
        container.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        container.layer.cornerRadius = 10
        
        container.layer.masksToBounds = false
        container.layer.shadowOffset = CGSize(width: 4, height: 4)
        container.layer.shadowRadius = 0
        container.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25).cgColor
        container.layer.shadowOpacity = 1
    }
}
