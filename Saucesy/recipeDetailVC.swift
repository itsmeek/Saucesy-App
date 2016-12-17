//
//  recipeDetailVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/7/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipeDetailVC: UITableViewController, DismissDelegate {
    
    private let cellId = "homeDetailcellId"
    private let headerId = "homdeDetailHeadercellId"
    

    //makes table style grouped
    override init(style: UITableViewStyle){
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        
        setupViews()
        
        tableView.register(ingredientsCell.self, forCellReuseIdentifier: cellId)
        tableView.register(RecipeDetailHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
    }
    
    //Hides status bar of the whole apllication
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
//        self.navigationController?.view.ins
        
        self.view.addSubview(viewRecipeButton)
        
    self.navigationController?.view.addConstraintsWithFormat(format: "H:|[v0]|", views: viewRecipeButton)
        self.navigationController?.view.addConstraintsWithFormat(format: "V:[v0(52)]|", views: viewRecipeButton)
        
    }
    

    //Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ingredientsCell
        cell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        return cell
    }
    
    //Section Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! RecipeDetailHeader
        
        header.contentView.backgroundColor = .white
        
        header.delegate = self
    
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 336.0
    }

    func styleComponents(){
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
}


class ingredientsCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addButton:UIButton = {
        let button = UIButton()
        let addIcon: UIImage = UIImage(named: "addIcon")!
        button.setImage(addIcon, for: .normal)
        return button
    }()
    
    let recipeLabel: UILabel = {
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
        addConstraintsWithFormat(format: "V:[v0]-10-|", views: addButton)
        
        addConstraintsWithFormat(format: "V:|-13-[v0]-12-|", views: recipeLabel)
        
    }
    
}

