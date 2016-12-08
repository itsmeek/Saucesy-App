//
//  recipesVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, Dismissing {
    
    private let recipeCellId = "recipeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        
        setupNavBar()
        
        //Programatically sets the reuse identifier
        collectionView?.register(recipeCell.self, forCellWithReuseIdentifier: recipeCellId)
        
    }
    
    func dismiss() {
        navigationController?.popToRoot(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellId, for: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 362.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeDetail = recipeDetailVC(style: .grouped)
        recipeDetail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recipeDetail, animated: true)
//        navigationController?.isNavigationBarHidden = true
        print("selected")
    }
    
    //Handles phone rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            setTabBarVisible(visible: false, animated: true)
//        }else{
//            setTabBarVisible(visible: true, animated: true)
//        }
//    }
    
    //Filter tab bar
    func setupNavBar(){
        let filterNavIcon = UIImage(named: "filterNavIcon")?.withRenderingMode(.alwaysOriginal)
        let filterBarIcon = UIBarButtonItem(image: filterNavIcon, style: .plain, target: self, action: #selector(handleFilter))
        navigationItem.rightBarButtonItem = filterBarIcon
    }
    
    func handleFilter(){
        print("124")
    }
    
    func styleComponents(){
        
        //Changes the title text "Saucesy" to logo
        let logo = UIImage(named: "logo")
        navigationItem.titleView = UIImageView(image: logo)
        
        //Sets status bar to white. Must go to info.plist and set the "View controller-based status bar appearance" to NO
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        
        collectionView?.showsVerticalScrollIndicator = false
    }
}







