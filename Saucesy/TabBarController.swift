//
//  TabBarController.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        
        // recipes collection view
        let layout = UICollectionViewFlowLayout()
        let recipesController = RecipesVC(collectionViewLayout: layout)
        let recipesNC = UINavigationController(rootViewController: recipesController)
        
        //Changes text color of tab bar bottom text
        let attributesNormal = [
            NSForegroundColorAttributeName : UIColor.saucesyBlue,
            NSFontAttributeName : UIFont(name: "Avenir", size: 10.0)!
            ] as [String : Any]
        
        let attributesSelected = [
            NSForegroundColorAttributeName : UIColor.saucesyRed,
            NSFontAttributeName : UIFont(name: "Avenir", size: 10.0)!
            ] as [String : Any]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        
        //Changes image of tab bar
        recipesNC.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(named: "recipesBarItem")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "recipesBarItemFilled"))
        
        //Tint color of selected Item
        self.tabBar.tintColor = UIColor.saucesyRed
        
        //removes Background Blur
        self.tabBar.barTintColor = .white
        
        //Array of view controllers in tab bar
        viewControllers = [recipesNC, createController(controllerName: "ingredients"), createController(controllerName: "list"), createController(controllerName: "liked")]
    }
    
    private func createController(controllerName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem = UITabBarItem(title: "\(controllerName)".capitalized, image: UIImage(named: "\(controllerName)BarItem")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "\(controllerName)BarItemFilled"))
        
        return navController
    }
}
