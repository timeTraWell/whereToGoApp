//
//  TitleCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var titleLabel: UILabel!

    //MARK:- UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.contentMode = .bottom
        titleLabel.font = Fonts.getFont(fontName: "SFProDisplay-Medium", size: 30)
        titleLabel.textColor = Color.black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
}
