//
//  NavigationCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 25/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class NavigationCell: UITableViewCell {

    @IBOutlet weak var logoPic: UIImageView!
    @IBOutlet weak var navButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNavButton()
        // Initialization code
    }
    
    //MARK: - Private helpers
    
    private func setupNavButton() {
        navButton.titleLabel?.font = Fonts.getFont(fontName: "SFProText-Semibold", size: 17)
        navButton.setTitleColor(Color.navOrange, for: .normal)
        
        navButton.centerTextAndImage(spacing: -6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
    
}
