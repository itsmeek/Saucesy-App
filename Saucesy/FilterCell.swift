//
//  FilterCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/10/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

class FilterCell: BaseCell {
    
    var filterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 14.0)
        return label
    }()
    
    let uncheckedBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(filterLabel)
        addSubview(uncheckedBtn)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]", views: filterLabel)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: filterLabel)
        
        uncheckedBtn.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 24, heightConstant: 24)
    }
}
