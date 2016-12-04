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
        let recipesController = recipesVC(collectionViewLayout: layout)
        let recipesNC = UINavigationController(rootViewController: recipesController)
        recipesNC.tabBarItem.title = "Recipes"
        recipesNC.tabBarItem.image = UIImage(named: "recipesBarItem")
        
        //Array of view controllers in tab bar
        viewControllers = [recipesNC, createController(controllerName: "ingredients"), createController(controllerName: "list"), createController(controllerName: "liked")]
    }
    
    private func createController(controllerName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = "\(controllerName)".capitalized
        navController.tabBarItem.image = UIImage(named: "\(controllerName)BarItem")
        return navController
    }
    
}
