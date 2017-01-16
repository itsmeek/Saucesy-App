//
//  RecipeCell.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    //Whenever dequed, cell calls init with frame and here is where we want to override it and add our views
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recipe: Recipe? {
        didSet{
            
            setupRecipeImage()
            
            //Sets Recipe name
            recipeName.text = recipe?.name
            
            //Sets Recipe description
            recipeDescription.text = recipe?.ingredients.joined(separator: " • ")
            
            //Sets Recipe calories
            if let data = recipe?.calories{
                SaucesyLabel.setAttributedText(on: recipeCalories, data: data, append: "calories")
            }
            
            //Sets Recipe servings
            if let data = recipe?.servings{
                SaucesyLabel.setAttributedText(on: recipeServings, data: data, append: "servings")
            }
        }
    }
    
    
    let recipeImage: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "foodImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let recipeName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipeDescription: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.saucesyLightBlue
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont(name: "Avenir", size: 14.0)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.maximumNumberOfLines = 3
        textView.textContainer.lineBreakMode = .byTruncatingTail
        return textView
    }()
    
    let recipeCalories: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 13.0)
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
        return label
    }()
    
    let recipeServings: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 13.0)
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
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
    
    func setupRecipeImage(){
        if let recipePhotoUrl = recipe?.image{
            recipeImage.loadImageUsingUrlString(urlString: recipePhotoUrl)
        }
    }
    
    func setupViews(){
        //Sets background color and adds subtle shadow
        backgroundColor = UIColor.white
        addShadow()
        
        addSubview(recipeImage)
        addSubview(recipeName)
        addSubview(likeButton)
        
        //Constraints for food Image
        addConstraintsWithFormat(format: "H:|[v0]|", views: recipeImage)
        addConstraintsWithFormat(format: "V:|[v0(222)]", views: recipeImage)
        
        //Constraints for food Name
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .top, relatedBy: .equal, toItem: recipeImage, attribute: .bottom, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .left, relatedBy: .equal, toItem: recipeImage, attribute: .left, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .right, relatedBy: .equal, toItem: recipeImage, attribute: .right, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: recipeName, attribute: .height, relatedBy: .equal, toItem: self , attribute: .height, multiplier: 0, constant: 22))
        
        
        //Stackview for recipeCalories and recipeServings ([calories][servings])
        let recipeInfoStackView = UIStackView(arrangedSubviews: [recipeCalories, recipeServings])
        recipeInfoStackView.axis = .horizontal
        recipeInfoStackView.distribution = .fillProportionally
        recipeInfoStackView.alignment = .leading
        recipeInfoStackView.spacing = 10
        recipeInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Stackview for recipeInfo([calories][servings]) and recipeDescription
        let recipeDetailsStackView = UIStackView(arrangedSubviews: [recipeDescription, recipeInfoStackView])
        recipeDetailsStackView.axis = .vertical
        recipeDetailsStackView.distribution = .fill
        recipeDetailsStackView.alignment = .leading
        recipeDetailsStackView.spacing = 12
        recipeDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(recipeDetailsStackView)
        
        //Constraints for RecipeDetails StackView
        addConstraint(NSLayoutConstraint(item: recipeDetailsStackView, attribute: .top, relatedBy: .equal, toItem: recipeName, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: recipeDetailsStackView)
        addConstraintsWithFormat(format: "V:[v0]-0-|", views: recipeDetailsStackView)
        
        //Constraints for recipeDescription
        addConstraint(NSLayoutConstraint(item: recipeDescription, attribute: .width, relatedBy: .equal, toItem: recipeDetailsStackView, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: recipeDescription, attribute: .height, relatedBy: .equal, toItem: self , attribute: .height, multiplier: 0, constant: 57))
        
        //Maskes sure that stack view is not covering the like button
        insertSubview(likeButton, aboveSubview: recipeDetailsStackView)
        
        //Like Button Constraints
        addConstraintsWithFormat(format: "H:[v0]-36-|", views: likeButton)
        addConstraintsWithFormat(format: "V:[v0]-14-|", views: likeButton)
    }
}
