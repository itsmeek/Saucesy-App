//
//  RecipesVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit
var currentRecipe: Recipe!

class RecipesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var recipies: [Recipe]?
    
    private let recipeCellId = "recipeCellId"
    
    func fetchData(){
        ApiService.sharedInstance.downloadRecipe { (recipies: [Recipe]) in
            self.recipies = recipies
            self.collectionView?.reloadData()
        }
    }
    
    func fetchMoreData(){
        ApiService.sharedInstance.downloadMore { (recipies: [Recipe]) in
            self.recipies = recipies
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        fetchData()
        setupNavBar()
        setupMenuBar()
        
        //Programatically sets the reuse identifier
        collectionView?.register(RecipeCell.self, forCellWithReuseIdentifier: recipeCellId)
        
        
        collectionView?.contentInset = UIEdgeInsetsMake(38, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(38, 0, 0, 0)
    }
    
    //Collection View
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellId, for: indexPath) as! RecipeCell
        
        if let recipe = recipies?[indexPath.item]{
            cell.recipe = recipe
        }
        
        if indexPath.row == (recipies?.count)! - 1{
            fetchMoreData()
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
        
        if let selectedRecipe = recipies?[indexPath.item]{
            showRecipeDetailFor(recipe: selectedRecipe)
        }
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showRecipeDetailFor(recipe: Recipe){
        let recipeDetail = RecipeDetailVC()
        recipeDetail.hidesBottomBarWhenPushed = true
        
        //Animation YEAAHH
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        transition.type = kCATransitionFade
        navigationController?.view.layer.add(transition, forKey: nil)
        
        recipeDetail.recipe = recipe
        
        
        
        //pushing
//        recipeDetail.header.recipeHeaderTitle.text = "Working"
//        recipeDetail.header.recipeHeaderTitle.text = currentRecipe.name
        navigationController?.pushViewController(recipeDetail, animated: false)

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
    
    //Solves fat view controller when you have too nuch code in a function that has nothing to do with the VC
    let filterLauncher = FilterLauncher()
    
    func handleFilter(){
        filterLauncher.handleFilter()
    }
    
    
    func styleComponents(){
        //Changes the title text Featured
        navigationItem.title = "Featured"
        
        if let nav = self.navigationController?.navigationBar{
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 17)!]
        }
        
        //Makes navigation bar no see through
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        
    }
    
    let menubar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    //private because no other class should have access
    fileprivate func setupMenuBar(){
        
        view.addSubview(menubar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menubar)
        view.addConstraintsWithFormat(format: "V:|[v0(38)]", views: menubar)
    }
}







