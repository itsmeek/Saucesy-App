//
//  SearchVC.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 1/17/17.
//  Copyright © 2017 Saucesy. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
       styleComponents()
    }
    
    func styleComponents(){
        //Changes the title text Featured
        navigationItem.title = "Search"
        
        if let nav = self.navigationController?.navigationBar{
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 17)!]
        }
        
        //Makes navigation bar no see through
        navigationController?.navigationBar.isTranslucent = false
        
    }
}
