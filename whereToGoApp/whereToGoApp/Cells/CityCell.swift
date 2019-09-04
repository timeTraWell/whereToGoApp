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
    @IBOutlet weak var cityName: UILabel!    
    @IBOutlet weak var container: UIView!
    
    //MARK:- TableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initContainer()
        cityName.font = Fonts.getFont(fontName: "SFProText-Bold", size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Setup func
    func setupCell(city: String) {
        cityName.text = city
    }
    
    //MARK:- Private helper
    private func initContainer() {
        container.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        container.layer.cornerRadius = 10
        
        container.layer.masksToBounds = false
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 12
        container.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15).cgColor
        container.layer.shadowOpacity = 1
    }
}
