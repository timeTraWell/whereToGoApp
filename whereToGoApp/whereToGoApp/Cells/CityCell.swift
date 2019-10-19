//
//  CityCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class CityCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var container: UIView!
    
    // MARK: - Properties
    
    private var cityName: String?
    private var citySlug: String?
    
    //MARK :- UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initContainer()
        cityNameLabel.font = Fonts.getFont(fontName: "SFProText-Bold", size: 16)
        cityNameLabel.textColor = Color.navOrange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
    
    // MARK: - Internal helpers
    
    func setupCell() {
        cityNameLabel.text = self.cityName
    }
    
    func setData(name: String, slug: String) {
        self.cityName = name
        self.citySlug = slug
    }
    
    // MARK: - Private helper

    private func initContainer() {
        container.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        container.layer.cornerRadius = 10
        container.layer.borderColor = Color.navOrange.cgColor
        container.layer.borderWidth = 1.0
    }
}
