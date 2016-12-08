//
//  recipeDetailVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/7/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipeDetailVC: UITableViewController {

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
        
        tableView.delegate = self
        
        tableView.register(ingredientsCell.self, forCellReuseIdentifier: cellId)
        tableView.register(igredientsCellHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 336.0
    }

    func styleComponents(){
        tableView.showsVerticalScrollIndicator = false
    }
    

}

//Custom Header
class igredientsCellHeader: UITableViewHeaderFooterView{
        
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
        let buttonImage = UIImage(named: "closeIcon")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    func dismissVC(){
//        recipeDetailVC.navigationController?.popToRootViewController(animated: true)
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


class ingredientsCell:UITableViewCell{
}
