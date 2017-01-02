//
//  BaseCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/28/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){}
}
