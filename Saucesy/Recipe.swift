//
//  Recipe.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/19/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class Recipe{
    
    private var _image: String!
    private var _name: String!
    private var _healthLabels: Array<String>!
    private var _ingredients: Array<String>!
    private var _calories: Int!
    private var _servings: Int!
    
    var image: String {
        if _image == nil{
            _image = ""
        }
        return _name
    }
    
    var name: String {
        if _name == nil{
            _name = ""
        }
        return _name
    }
    
    var healthLabels: Array<String>{
        if _healthLabels == nil{
            _healthLabels = [""]
        }
        return _healthLabels
    }
    
    var ingredients: Array<String> {
        if _ingredients == nil{
            _ingredients = [""]
        }
        return _ingredients
    }
    
    var calories: Int {
        if _calories == nil{
            _calories = 0
        }
        return _calories
    }
    
    var servings: Int {
        if _servings == nil{
            _servings = 0
        }
        return _servings
    }
    
    init(image: String, name: String, healthLabels: Array<String>, ingredients: Array<String>, calories: Int, servings: Int) {
        self._image = image
        self._name = name
        self._healthLabels = healthLabels
        self._ingredients = ingredients
        self._calories = calories
        self._servings = servings
    }
    
}
