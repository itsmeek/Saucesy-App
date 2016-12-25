//
//  AllergiesCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/14/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class AllergiesCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dietLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir", size: 13.0)
        return label
    }()
    
    func configureCell(name: String){
        dietLabel.text = name
    }
    
    func setupViews(){
        addSubview(dietLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dietLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dietLabel)
    }
}


