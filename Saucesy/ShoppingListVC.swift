//
//  ShoppingListVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/18/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit
import CoreData

struct List {
    var listTitle: String!
    var lists: [String]!
}


class ShoppingListVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    
    var frc: NSFetchedResultsController<ShoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        setupNavBar()
        
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.separatorStyle = .none
        
        tableView.register(ShoppingListCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ShoppingListHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
    }
    
    var shoppingLists: [List] = {
        return [List(listTitle: "unpurchased".uppercased(), lists: ["Test 1", "Test 2", "Test 3"]),List(listTitle: "Purchased".uppercased(), lists: ["Test 1", "Test 2", "Test 3"])]
    }()
    
    func styleComponents(){
        //Changes the title text Featured
        navigationItem.title = "My Shopping List"
        
        if let nav = self.navigationController?.navigationBar{
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 17)!]
        }
        //Makes navigation bar no see through
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupNavBar(){
        let filterBarIcon = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItem = filterBarIcon
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        if let font = UIFont(name: "Avenir", size: 14.0){
            filterBarIcon.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
        }
    }
    
    func handleEdit(){
        print(123)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return shoppingLists.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists[section].lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!  ShoppingListCell
        
        cell.filterLabel.text = shoppingLists[indexPath.section].lists[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! ShoppingListHeader
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //removes 20px padding for the footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //CORE DATA
    func attemptFetch(){
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = newIndexPath{
                let cell = tableView.cellForRow(at: indexPath)
                //update cell data
            }
            break
        default:
            print("default")
        }
    }
    
    
}

class ShoppingListCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var filterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 14.0)
        return label
    }()
    
    let uncheckedBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    func setupViews() {
        addSubview(filterLabel)
        addSubview(uncheckedBtn)
        
        uncheckedBtn.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        filterLabel.anchor(self.topAnchor, left: self.uncheckedBtn.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
    }
}

class ShoppingListHeader: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Unpurchased".uppercased()
        label.textColor = UIColor.saucesyRed
        label.font = UIFont(name: "Avenir", size: 12)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerLabelCount: UILabel = {
        let label = UILabel()
        label.text = "3 items"
        label.textColor = UIColor.saucesyRed
        label.font = UIFont(name: "Avenir", size: 14)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        addSubview(headerLabel)
        addSubview(headerLabelCount)
        
        headerLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        headerLabelCount.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
}
