//
//  recipeDetailVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/7/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DismissDelegate {
    
    
    var recipe: Recipe? {
        didSet{
//            Set Image
            
        }
    }
    
    private let cellId = "homeDetailcellId"
    private let headerId = "homdeDetailHeadercellId"
    
    var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: cellId)
        tableView.register(RecipeDetailHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        styleComponents()

        print(recipe?.healthLabels)
        
        
    }
    
    //Hides status bar of the whole apllication
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func dismissVC() {
        navigationController?.pop(animated: true)
    }
    
    let viewRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Recipe", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.saucesyBlue
        return button
    }()
    
    func setupViews(){
        self.view.addSubview(tableView)
        self.view.addSubview(viewRecipeButton)
        tableView.backgroundColor = UIColor.black
        
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]-0-[v1(52)]-|", views: tableView, viewRecipeButton)
        
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: viewRecipeButton)
    }
    

    //Tableview
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = recipe?.ingredients.count{
            return count
        }
        
        return 0
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = UIColor.clear
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IngredientsCell
        
        if let recipe = recipe?.ingredients[indexPath.row]{
            cell.recipeLabel.text = recipe
        }
        cell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        cell.selectedBackgroundView = selectedBackground
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row + 1) selected")
        let cell = self.tableView.cellForRow(at: indexPath) as! IngredientsCell
        cell.sendToCoreData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row + 1) delselected")
        let cell = self.tableView.cellForRow(at: indexPath) as! IngredientsCell
        cell.sendToCoreData()
    }
    
    //Section Header
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! RecipeDetailHeader
        
        header.contentView.backgroundColor = .white
        
        header.delegate = self
        
        if let name = recipe?.name{
            header.recipeHeaderTitle.text = name
        }
        
        if let calories = recipe?.calories{
            SaucesyLabel.setAttributedText(on: header.recipeHeaderCalories, data: calories, append: "calories")
        }
        
        if let servings = recipe?.servings{
            SaucesyLabel.setAttributedText(on: header.recipeHeaderCalories, data: servings, append: "servings")
        }
        
        header.recipeDetail = self
    
        return header
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 336.0
    }
    
    //removes 20px padding for the footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func styleComponents(){
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
}


