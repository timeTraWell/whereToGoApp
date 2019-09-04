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

    //MARK:- TableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Setup func
    func setupCell(city: String) {
        cityName.text = city
    }
    
}
