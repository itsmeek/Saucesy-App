//
//  IngredientsCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/18/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class IngredientsCell:UITableViewCell{
    
    var isChecked: Bool!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
        isChecked = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addButton:UIButton = {
        let button = UIButton()
        let unselectedImage = UIImage(named: "addIcon")! as UIImage
        button.setImage(unselectedImage, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    func sendToCoreData(){
        let addImage = UIImage(named: "addIcon")! as UIImage
        let addedImage = UIImage(named: "checkIcon")! as UIImage
        if isChecked == true{
            addButton.setImage(addImage, for: .normal)
            isChecked = false
        } else {
            addButton.setImage(addedImage, for: .normal)
            isChecked = true
        }
    }
    
    var recipeLabel: UILabel = {
        let label = UILabel()
        let recipeNameText = "1 tablespoon fresh lime juice"
        label.text = recipeNameText
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 14.0)
        label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
        return label
    }()
    
    func setupViews(){
        
        addSubview(addButton)
        addSubview(recipeLabel)
        
        addConstraintsWithFormat(format: "H:|-15-[v0(24)]-13-[v1]-15-|", views: addButton, recipeLabel)
        addConstraintsWithFormat(format: "V:[v0(24)]-10-|", views: addButton)
        
        addConstraintsWithFormat(format: "V:|-13-[v0]-12-|", views: recipeLabel)
    }
}
