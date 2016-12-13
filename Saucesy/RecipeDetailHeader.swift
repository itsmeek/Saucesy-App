//
//  recipeDetailHeader.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/12/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

protocol dismissDelegate {
    func dismissVC()
}

//Custom Header
class RecipeDetailHeader: UITableViewHeaderFooterView{
    
    var delegate: dismissDelegate? = nil
    
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "foodImage")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.frame = (frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        let buttonImage = UIImage(named: "closeIcon")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(btnDismiss), for: .touchUpInside)
        return button
    }()
    
    func btnDismiss(){
        delegate?.dismissVC()
    }
    
    func setupHeader() {
        addSubview(headerImage)
        addSubview(closeButton)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: headerImage)
        addConstraintsWithFormat(format: "V:|[v0(260)]|", views: headerImage)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(28)]", views: closeButton)
        addConstraintsWithFormat(format: "V:|-25-[v0(28)]", views: closeButton)
    }
}
