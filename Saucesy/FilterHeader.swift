//
//  FilterHeader.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/10/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

class FilterHeader: BaseCell {
    
    let filterHeader: UILabel = {
        let label = UILabel()
        label.text = "diet".uppercased()
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 12.0)
        label.font = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        
        addSubview(filterHeader)
        
        filterHeader.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}


