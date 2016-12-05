//
//  recipesVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class recipesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let recipeCellId = "recipeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Changes the title text "Saucesy" to logo
        let logo = UIImage(named: "logo")
        navigationItem.titleView = UIImageView(image: logo)
        
        //Sets status bar to white. Must go to info.plist and set the "View controller-based status bar appearance" to NO
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
                
        //Programatically sets the reuse identifier
        collectionView?.register(recipeCell.self, forCellWithReuseIdentifier: recipeCellId)
        
        collectionView?.showsVerticalScrollIndicator = false
        
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            setTabBarVisible(visible: false, animated: true)
        }else{
            setTabBarVisible(visible: true, animated: true)
        }
    }
    
    
}







