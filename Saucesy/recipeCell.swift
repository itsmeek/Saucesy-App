//
//  recipeCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipeCell: UICollectionViewCell {
    
    //Whenever dequed, cell calles init with frame and here is where we want to override it and add our views
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "foodImage")
        return imageView
    }()
    
    func setupViews(){
        //Sets background color and adds subtle shadow
        backgroundColor = UIColor.white
        addShadow()
        
        addSubview(foodImage)
        
        //Constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: foodImage)
        addConstraintsWithFormat(format: "V:|[v0(222)]", views: foodImage)
        
    }
}
