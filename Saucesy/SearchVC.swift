//
//  SearchVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/17/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var cellId = "cellId"
    
//    var tableView: UITableView = UITableView()
    let trendingTable: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView(frame: .zero)
        return table
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.barTintColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.5)
        search.setImage(#imageLiteral(resourceName: "searchBarIcon"), for: .search, state: .normal)
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.white.cgColor
        return search
    }()
    
    var trending: [String] = ["Chinese", "Pizza", "Sweet", "Thai", "Dessert", "Breakfast", "Bbq", "Healthy", "Spicy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        trendingTable.delegate = self
        trendingTable.dataSource = self
        
        styleComponents()
        setupViews()
    }
    
    func styleComponents(){
        //Changes the title text Featured
        navigationItem.title = "Search"
        
        if let nav = self.navigationController?.navigationBar{
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 17)!]
        }
        //Makes navigation bar no see through
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trending.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.selectionStyle = .none
        
        if let label = cell.textLabel{
            label.text = trending[indexPath.row]
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.saucesyRed
            label.font = UIFont(name: "Avenir", size: 15)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        searchBar.text = trending[indexPath.row]
        
    }
    
    
    
    func setupViews(){
        
        
        
        //search bar customizations
        let textfield = searchBar.value(forKey: "searchField") as? UITextField
        textfield?.textColor = UIColor.saucesyRed
        textfield?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.5)
        textfield?.attributedPlaceholder = NSAttributedString(string: "Search Ingredients                                                               ", attributes: [NSForegroundColorAttributeName:UIColor(red: 80/255, green: 105/255, blue: 126/255, alpha: 0.5), NSFontAttributeName: UIFont(name: "Avenir", size: 14)!])
        
        
        view.addSubview(searchBar)
        view.addSubview(trendingTable)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: searchBar)
        view.addConstraintsWithFormat(format: "V:|[v0(45)]", views: searchBar)
        
        trendingTable.anchor(searchBar.bottomAnchor, left: self.view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
