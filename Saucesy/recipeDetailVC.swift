//
//  recipeDetailVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/7/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipeDetailVC: UITableViewController, dismissDelegate {
    
    var recipeDetailHeader = RecipeDetailHeader()
    
    private let cellId = "homeDetailcellId"
    private let headerId = "homdeDetailHeadercellId"
    
    

    //makes style grouped
    override init(style: UITableViewStyle){
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        styleComponents()
        
        tableView.register(ingredientsCell.self, forCellReuseIdentifier: cellId)
        tableView.register(RecipeDetailHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        recipeDetailHeader.delegate = self
    }
    
    func dismissVC() {
        print("Test")
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    //Section Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! RecipeDetailHeader
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 336.0
    }

    func styleComponents(){
        tableView.showsVerticalScrollIndicator = false
    }
    
    


  
}


class ingredientsCell:UITableViewCell{
    
}

