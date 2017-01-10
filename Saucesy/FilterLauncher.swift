//
//  FilterLauncher.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/2/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

//Model Object
struct Filter {
    var filterSection: String!
    var filters: [String]!
}

class FilterLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let blackView = UIView()
    let cellId = "cellId"
    let headerId = "headerId"
    
    
    var filters: [Filter] = {
        return [Filter(filterSection: "Diet", filters: ["Vegetarian","Vegan","Paleo", "High-Fiber", "Hight-Protein", "Low Card"]), Filter(filterSection: "Allergies", filters: ["Gluten","Dairy","Eggs", "Soy", "Wheat", "Fish", "Shellfish", "Tree nuts", "Peanuts"])]
        }()
    
    let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let filterHeader: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 18.0)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func handleFilter(){
        
        //entire apps window
        if let window = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(wrapperView)
            
            //Wrapper View
            wrapperView.addSubview(headerView)
            wrapperView.addSubview(collectionView)
            
            
            collectionView.addSubview(filterHeader)

            //Wrapper View
            let height:CGFloat = (window.frame.height - 147)
            let frame = window.frame.height
            let y = window.frame.height - height
            wrapperView.frame = CGRect(x: 0, y: frame, width: window.frame.width, height: frame - 147)
            
            headerView.frame = CGRect(x: 0, y: 0, width: wrapperView.frame.width, height: 44)
            collectionView.frame = CGRect(x: 0, y: 44, width: wrapperView.frame.width, height: wrapperView.frame.height - 44)
            
            //Black View
            blackView.frame = window.frame
            blackView.alpha = 0
            
            setupHeader()
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.wrapperView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: window.frame.height - 147)
                }, completion: nil)
        }

    }
    
    
    func setupHeader(){
        let filterTitle: UILabel = {
            let label = UILabel()
            label.text = "Filters"
            label.textColor = UIColor.saucesyBlue
            label.font = UIFont(name: "Avenir", size: 18.0)
            label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let resetButton: UIButton = {
            let button = UIButton()
            button.setTitle("Reset", for: .normal)
            button.setTitleColor(UIColor.saucesyRed, for: .normal)
            button.titleLabel?.font = UIFont(name: "Avenir", size: 14.0)
            return button
        }()
        
        let applyButton: UIButton = {
            let button = UIButton()
            button.setTitle("Apply", for: .normal)
            button.setTitleColor(UIColor.saucesyRed, for: .normal)
            button.titleLabel?.font = UIFont(name: "Avenir", size: 14.0)
            return button
        }()
        
        headerView.addSubview(filterTitle)
        headerView.addSubview(resetButton)
        headerView.addSubview(applyButton)
        
        filterTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        filterTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        resetButton.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        applyButton.anchor(headerView.topAnchor, left: nil, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)

    }
    
    func handleDismiss(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            //Only way to get access to the whole apps widow
            if let window = UIApplication.shared.keyWindow{
                self.wrapperView.frame = CGRect(x: 0, y: window.frame.height, width: self.wrapperView.frame.width, height: self.wrapperView.frame.height)
            }
        })
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters[section].filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterCell
        let filter = filters[indexPath.section].filters[indexPath.item]
        cell.filterLabel.text = filter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! FilterHeader
        let headerTitle = filters[indexPath.section].filterSection
        header.filterHeader.text = headerTitle?.uppercased()
        header.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 46.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        print(indexPath.item)
    }
    
    
    override init(){
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(FilterHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
}



class FilterHeader: BaseCell {
    
        let filterHeader: UILabel = {
            let label = UILabel()
            label.text = "diet".uppercased()
            label.textColor = UIColor.saucesyBlue
            label.font = UIFont(name: "Avenir", size: 12.0)
            label.font = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightSemibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override func setupViews() {
        
        addSubview(filterHeader)

        filterHeader.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class FilterCell: BaseCell {
    
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
    
    override func setupViews() {
        super.setupViews()
        addSubview(filterLabel)
        addSubview(uncheckedBtn)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]", views: filterLabel)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: filterLabel)
        
        uncheckedBtn.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 24, heightConstant: 24)
    }
}
