//
//  recipeDetailHeader.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/12/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

protocol DismissDelegate {
    func dismissVC()
}

//Custom Header
class RecipeDetailHeader: UITableViewHeaderFooterView{
    
    var delegate: DismissDelegate? = nil
    
    let allergyContainment: Array<String> = ["Vegetarian", "Egg-Free", "Peanut-Free", "Tree-Nut-Free"]
    
    var stackButton = [UIView]()
    
    
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        
        addAllergyContainment()

        setupHeader()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "foodImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeHeaderTitle: UILabel = {
        let label = UILabel()
        let recipeNameText = "Salsa Verde Chicken Bake"
        label.text = recipeNameText
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 18.0)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipeHeaderCalories: UILabel = {
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
    
    let recipeHeaderServings: UILabel = {
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
    
   
    
    lazy var recipeHeaderCloseButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "closeIcon")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(btnDismiss), for: .touchUpInside)
        return button
    }()
    
    func btnDismiss(){
        delegate?.dismissVC()
    }
    
    func addAllergyContainment(){
        
        for x in 0..<allergyContainment.count{
            let button = UIButton()
            
//            var newX: CGFloat = 0.0
        
            button.setTitle("   \(allergyContainment[x])   ", for: .normal)
            button.backgroundColor = UIColor.saucesyBlue
            button.titleLabel?.font = UIFont(name: "Avenir", size: 13.0)
            button.sizeToFit()
            var buttonWidth = button.frame.size.width
            var buttonHeight = button.frame.size.height
            button.layer.cornerRadius = buttonHeight / 2
            buttonWidth += 20
            buttonHeight -= 8
            
            print(buttonHeight)
            
            stackButton.append(button)
            
//            self.addSubview(button)
//            
//            var newX = button.frame.width * CGFloat(x)
            
//            print("Button width is \(button.frame.width) and new x is \(newX)")
            
//            button.frame.origin = CGPoint(x: newX, y: 0)


            
        }
    }
    func setupHeader() {
        addSubview(headerImage)
        addSubview(recipeHeaderCloseButton)
        
        //Stackview for recipeCalories and recipeServings ([recipeHeaderCalories][recipeHeaderServings])
        let recipeInfoStackView = UIStackView(arrangedSubviews: [recipeHeaderCalories, recipeHeaderServings])
        recipeInfoStackView.axis = .horizontal
        recipeInfoStackView.distribution = .fillProportionally
        recipeInfoStackView.alignment = .leading
        recipeInfoStackView.spacing = 10
        recipeInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Stackview for recipeHeaderTitle and recipeInfoStackView ([recipeHeaderTitle][recipeInfoStackView])
        let recipeDetailStackView = UIStackView(arrangedSubviews: [recipeHeaderTitle, recipeInfoStackView])
        recipeDetailStackView.axis = .vertical
        recipeDetailStackView.distribution = .fillProportionally
        recipeDetailStackView.alignment = .leading
        recipeDetailStackView.spacing = 9
        recipeDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(recipeDetailStackView)
        
        let allergiesStackView = UIStackView(arrangedSubviews: stackButton)
        allergiesStackView.axis = .horizontal
        allergiesStackView.distribution = .fill
        allergiesStackView.alignment = .leading
        allergiesStackView.spacing = 8
        allergiesStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(allergiesStackView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: headerImage)
        addConstraintsWithFormat(format: "V:|[v0(260)]-15-[v1]", views: headerImage, recipeDetailStackView)
        
        addConstraintsWithFormat(format: "H:|-1-[v0(36)]", views: recipeHeaderCloseButton)
        addConstraintsWithFormat(format: "V:|-1-[v0(36)]", views: recipeHeaderCloseButton)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: recipeDetailStackView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: allergiesStackView)
        
        addConstraint(NSLayoutConstraint(item: allergiesStackView, attribute: .bottom, relatedBy: .equal, toItem: headerImage, attribute: .bottom, multiplier: 1, constant: -8))
//        addConstraint(NSLayoutConstraint(item: allergiesStackView, attribute: .left, relatedBy: .equal, toItem: headerImage, attribute: .left, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: allergiesStackView, attribute: .right, relatedBy: .equal, toItem: headerImage, attribute: .right, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: allergiesStackView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 33))
        
    }
}
