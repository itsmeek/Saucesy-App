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
class RecipeDetailHeader: UITableViewHeaderFooterView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var recipeDetail = RecipeDetailVC()
    
    var cellClass = AllergiesCell()
    
    private let cellId = "allergyCellId"
    
    var delegate: DismissDelegate? = nil
    
    let allergies = ["Egg-Free", "Peanut-Free", "Tree-Nut-Free", "Soy-Free", "Fish-Free", "Shellfish-Free"]
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
        print(recipeDetail)
        if let recipe = recipeDetail.recipe{
            print(recipe.healthLabels)
        }else{
            print("Didnt reach")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AllergiesCell
        
        cell.configureCell(name: allergies[indexPath.item])
        
//        if let name = recipeDetail.recipe?.healthLabels[indexPath.item] {
//            cell.configureCell(name: name)
//        }
        
        cell.contentView.backgroundColor = UIColor.saucesyBlue
        cell.contentView.layer.cornerRadius = 22 / 2
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (allergies[indexPath.item]).size(attributes: nil).width
        return CGSize(width: width + 30, height: collectionView.frame.size.height - 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 20, 0, 20)
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
    
    let allergiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        return collectionView
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
    
    
    func setupHeader() {
        addSubview(headerImage)
        addSubview(recipeHeaderCloseButton)
        addSubview(allergiesCollectionView)
        
        
        allergiesCollectionView.delegate = self
        allergiesCollectionView.dataSource = self
        
        allergiesCollectionView.register(AllergiesCell.self, forCellWithReuseIdentifier: cellId)
        
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
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: headerImage)
        addConstraintsWithFormat(format: "V:|[v0(260)]-15-[v1]", views: headerImage, recipeDetailStackView)
        
        addConstraintsWithFormat(format: "H:|-1-[v0(36)]", views: recipeHeaderCloseButton)
        addConstraintsWithFormat(format: "V:|-1-[v0(36)]", views: recipeHeaderCloseButton)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: recipeDetailStackView)
        
        addConstraint(NSLayoutConstraint(item: allergiesCollectionView, attribute: .right, relatedBy: .equal, toItem: headerImage, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: allergiesCollectionView, attribute: .left, relatedBy: .equal, toItem: headerImage, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: allergiesCollectionView, attribute: .bottom, relatedBy: .equal, toItem: headerImage, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: allergiesCollectionView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 52))
        
    }
}

