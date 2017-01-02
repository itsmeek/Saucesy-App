//
//  MenuCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/1/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {

    var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 12.0)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.saucesyLightBlue
        return label
    }()
    
    override var isHighlighted: Bool{
        //exectuted any cell is selected
        didSet{
            //ternary operator: shorthand for an if statement
            menuLabel.textColor = isHighlighted ? UIColor.saucesyRed : UIColor.saucesyLightBlue
        }
    }
    
    override var isSelected: Bool{
        didSet{
            menuLabel.textColor = isSelected ? UIColor.saucesyRed : UIColor.saucesyLightBlue
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(menuLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: menuLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: menuLabel)
        addConstraint(NSLayoutConstraint(item: menuLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
