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


class ShoppingListVC: UITableViewController, NSFetchedResultsControllerDelegate, UITextViewDelegate {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    
    var frc: NSFetchedResultsController<ShoppingList>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        setupNavBar()
        
        
        
//        generateTestData()
        
        loadSavedData()
        
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.separatorStyle = .none
        
        tableView.register(ShoppingListCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ShoppingListHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(ShoppingListFooter.self, forHeaderFooterViewReuseIdentifier: footerId)
    }
    
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
        
        guard let section = frc.sections else {return 0}
        
        return section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = frc.sections?[section] else {return 0}
        
        return section.numberOfObjects
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!  ShoppingListCell
        
        updateCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func updateCell(cell: ShoppingListCell, indexPath: NSIndexPath){
        let item = frc.object(at: indexPath as IndexPath)
        cell.configureCell(shoppingList: item)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = frc.object(at: indexPath)
        
        if !item.purchased{
            item.purchased = true
        }else{
            item.purchased = false
        }
        
        ad.saveContext()
//        tableView.reloadData()
        
    }
    
    //Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! ShoppingListHeader
        
        guard let section1 = frc.sections?[section] else {fatalError("Unexpected Section")}
        
        header.headerLabelCount.text = "\(section1.numberOfObjects) Items"
        
        print(section1)
        
        switch section{
        case 0:
            header.headerLabel.text = "UnPurchased"
        default:
            header.headerLabel.text = "Purchased"
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //Footer
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as! ShoppingListFooter
        
        switch section{
        case 1:
            footer.isHidden = true
        default:
            footer.isHidden = false
        }
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    //CORE DATA
    func loadSavedData(){
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        let purchased = "purchased"
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: purchased, cacheName: nil)
        
        controller.delegate = self
        
        frc = controller
        
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
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)

        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            
        case .move:
            print("MOVE")
            break
            
        case .update:
            print("UPDATE")
            break
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
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
                let cell = tableView.cellForRow(at: indexPath) as! ShoppingListCell
                updateCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func generateTestData(){
        let list = ShoppingList(context: context)
        list.item = "Saucesage"
        list.purchased = false
        
        let list2 = ShoppingList(context: context)
        list2.item = "Beer"
        list2.purchased = false
        
        ad.saveContext()
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
        label.font = UIFont(name: "Avenir", size: 15.0)
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
    
    func configureCell(shoppingList: ShoppingList){
        filterLabel.text = shoppingList.item
    }
}


class ShoppingListFooter: UITableViewHeaderFooterView, UITextViewDelegate, UITextFieldDelegate{

    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        self.contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let addBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addIcon"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let addField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.font = UIFont(name: "Avenir-Medium", size: 15)
        textfield.textColor = UIColor.saucesyBlue
        textfield.returnKeyType = .done
        return textfield
    }()
    
    func setupViews(){
        addSubview(addBtn)
        addSubview(addField)
        
        addField.delegate = self
        addField.attributedPlaceholder = NSAttributedString(string: "Add Ingredient", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 15)!])
        
        addConstraintsWithFormat(format: "H:|-15-[v0(24)]", views: addBtn)
        addConstraintsWithFormat(format: "V:|[v0]|", views: addBtn)
        
        addField.anchor(self.topAnchor, left: self.addBtn.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = addField.text, !text.isEmpty else {
            return false
        }
        
        instertData(text: text)
        
        addField.resignFirstResponder()
        return true
    }
    
    func instertData(text: String){
        
        let list = ShoppingList(context: context)
        
        list.item = text
        
        addField.text = ""

        list.purchased = false
        
        ad.saveContext()
    }

}

class ShoppingListHeader: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        self.contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
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
