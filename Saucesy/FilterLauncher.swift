//
//  FilterLauncher.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/2/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

class FilterLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let blackView = UIView()
    let cellId = "cellId"
    let headerId = "headerId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func handleFilter(){
        
        //entire apps window
        if let window = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            //Collection View
            let height:CGFloat = (window.frame.height - 147)
            let frame = window.frame.height
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: frame, width: window.frame.width, height: frame - 147)
            
            //Black View
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: window.frame.height - 147)
                }, completion: nil)
        }
    }
    
    func handleDismiss(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            //Only way to get access to the whole apps widow
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 46.0)
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
        label.text = "Filters"
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 18.0)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
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
    
    override func setupViews() {
        addSubview(filterHeader)
        addSubview(resetButton)
        addSubview(applyButton)
        
        filterHeader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        filterHeader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        resetButton.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        applyButton.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
    }
}



class FilterCell: BaseCell {
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Low Sugar"
        label.textColor = UIColor.saucesyBlue
        label.font = UIFont(name: "Avenir", size: 14.0)
        return label
    }()
    
    let uncheckedBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(filterLabel)
        addSubview(uncheckedBtn)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]-[v1(24)]-20-|", views: filterLabel, uncheckedBtn)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: filterLabel)
        
        addConstraintsWithFormat(format: "V:|-20-[v0(24)]", views: uncheckedBtn)

    }
}
