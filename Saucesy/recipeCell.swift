//
//  recipeCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipeCell: UICollectionViewCell {
    
    //Whenever dequed, cell calls init with frame and here is where we want to override it and add our views
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "foodImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let recipeName: UILabel = {
        let label = UILabel()
        let recipeNameText = "Salsa Verde Chicken Bake"
        label.text = recipeNameText
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 18.0)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipeDescription: UITextView = {
        let textView = UITextView()
        var recipeDescriptionText = "1 can (29 oz) pumpkin puree, 1 cup brown sugar, ¾ cup water, 1 tsp. vanilla extract, 1 tsp. cinnamon, 1 tsp. ground ginger, 1 cup brown sugar "
        textView.text = recipeDescriptionText
        textView.textColor = UIColor.saucesyLightBlue
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.textAlignment = NSTextAlignment.left
        textView.font = UIFont(name: "Avenir", size: 14.0)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.maximumNumberOfLines = 3
        textView.textContainer.lineBreakMode = .byTruncatingTail
        return textView
    }()
    
    let recipeCalories: UILabel = {
        let label = UILabel()
        let calories = "2360"
        let caloriesText = "CALORIES"
        let caloriesLabel = "\(calories) \(caloriesText)"
        label.textColor = UIColor.saucesyRed
        label.font = UIFont(name: "Avenir", size: 13.0)
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
        
        //Api request number (changing color)
        let range = (caloriesLabel as NSString).range(of: caloriesText)
        let attributedString = NSMutableAttributedString(string: caloriesLabel)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.saucesyBlue , range: range)
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipeServings: UILabel = {
        let label = UILabel()
        let servings = "5"
        let servingsText = "SERVINGS"
        let servingsLabel = "\(servings) \(servingsText)"
        label.textColor = UIColor.saucesyRed
        label.font = UIFont(name: "Avenir", size: 13.0)
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
        
        //Api request number (changing color)
        let range = (servingsLabel as NSString).range(of: servingsText)
        let attributedString = NSMutableAttributedString(string: servingsLabel)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.saucesyBlue , range: range)
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        let buttonEmpty: UIImage = UIImage(named: "likedBarItem")!
        button.setImage(buttonEmpty, for: .normal)
        button.addTarget(self, action: #selector(handleLikes), for: .touchUpInside)
        return button
    }()
    
    func handleLikes(){
        let buttonFilled: UIImage = UIImage(named: "likedBarItemFilled")!
        likeButton.setImage(buttonFilled, for: .normal)
    }
    
    func setupViews(){
        //Sets background color and adds subtle shadow
        backgroundColor = UIColor.white
        addShadow()
        
        //        bringSubview(toFront: likeButton)
        addSubview(likeButton)
        
        addSubview(recipeImage)
        addSubview(recipeName)
        
        //Constraints for food Image
        addConstraintsWithFormat(format: "H:|[v0]|", views: recipeImage)
        addConstraintsWithFormat(format: "V:|[v0(222)]", views: recipeImage)
        
        //        //Constraints for recipeDescription
        addConstraint(NSLayoutConstraint(item: recipeDescription, attribute: .left, relatedBy: .equal, toItem: recipeImage, attribute: .left, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: recipeDescription, attribute: .right, relatedBy: .equal, toItem: recipeImage, attribute: .right, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: recipeDescription, attribute: .height, relatedBy: .equal, toItem: self , attribute: .height, multiplier: 0, constant: 57))
        //
        //        //Stackview for recipeCalories and recipeServings
        let recipeInfoStackView = UIStackView(arrangedSubviews: [recipeCalories, recipeServings])
        recipeInfoStackView.axis = .horizontal
        recipeInfoStackView.distribution = .fillProportionally
        recipeInfoStackView.alignment = .leading
        recipeInfoStackView.spacing = 10
        recipeInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        //
        //        //Stackview for recipeInfo and recipeDescription
        let recipeDetailsStackView = UIStackView(arrangedSubviews: [recipeDescription, recipeInfoStackView])
        recipeDetailsStackView.axis = .vertical
        recipeDetailsStackView.distribution = .fillProportionally
        recipeDetailsStackView.alignment = .leading
        recipeDetailsStackView.spacing = 12
        recipeDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(recipeDetailsStackView)
        //
        //
        //        likeButton.bringSubview(toFront: self)
        insertSubview(likeButton, aboveSubview: recipeDetailsStackView)
        
        
        
        
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .top, relatedBy: .equal, toItem: recipeImage, attribute: .bottom, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .left, relatedBy: .equal, toItem: recipeImage, attribute: .left, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .right, relatedBy: .equal, toItem: recipeImage, attribute: .right, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .height, relatedBy: .equal, toItem: self , attribute: .height, multiplier: 0, constant: 18))
        //
        ////
        addConstraint(NSLayoutConstraint(item: recipeDetailsStackView, attribute: .top, relatedBy: .equal, toItem: recipeName, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: recipeDetailsStackView)
        addConstraintsWithFormat(format: "V:[v0]-0-|", views: recipeDetailsStackView)
        //
        addConstraintsWithFormat(format: "H:[v0]-36-|", views: likeButton)
        addConstraintsWithFormat(format: "V:[v0]-14-|", views: likeButton)
        
        
    }
    
    
}
