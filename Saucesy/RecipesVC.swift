//
//  RecipesVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class RecipesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var recipies: [Recipe]?
    
    private let recipeCellId = "recipeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        
        downloadRecipe { (recipies) in
            self.recipies = recipies
            self.collectionView?.reloadData()
        }
        
        setupNavBar()
        
        
        //Programatically sets the reuse identifier
        collectionView?.register(RecipeCell.self, forCellWithReuseIdentifier: recipeCellId)
        
    }
    
    //Collection View
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellId, for: indexPath) as! RecipeCell
        
        if let recipe = recipies?[indexPath.item]{
            cell.recipe = recipe
        }
        
        
        if indexPath.row == (recipies?.count)! - 1{
            downloadMore(completionHandler: { (newRecipies) in
                self.recipies = newRecipies
                self.collectionView?.reloadData()
            })
        }
        
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return count otherwise return 0
        return recipies?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 362.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeDetail = RecipeDetailVC()
        recipeDetail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recipeDetail, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    //Handles phone rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    //Hides tab bar when scrolling down
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            setTabBarVisible(visible: false, animated: true)
        }else{
            setTabBarVisible(visible: true, animated: true)
        }
    }
    
    //Adds filter icon to tab bar
    func setupNavBar(){
        let filterNavIcon = UIImage(named: "filterNavIcon")?.withRenderingMode(.alwaysOriginal)
        let filterBarIcon = UIBarButtonItem(image: filterNavIcon, style: .plain, target: self, action: #selector(handleFilter))
        navigationItem.rightBarButtonItem = filterBarIcon
    }
    
    func handleFilter(){
//        print("124")
    }
    
    
    func styleComponents(){
        //Changes the title text "Saucesy" to logo
        let logo = UIImage(named: "logo")
        navigationItem.titleView = UIImageView(image: logo)
        
        //Makes navigation bar no see through
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        
//        collectionView?.showsVerticalScrollIndicator = false
    }
}







