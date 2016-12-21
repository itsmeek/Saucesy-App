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

func downloadRecipe(){
    
    typealias jsonStandard = Dictionary<String,AnyObject>
    
    var listOfRecipies: Array = [Recipe]()
    
    //if let this
    let url = URL(string: "https://api.edamam.com/search?q=chicken&app_id=6a18017d&app_key=56b29c7fe0addda91493a8cb0f9d0e73")
    
    let urlRequest = URLRequest(url: url!)
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        if error != nil{
            print(error?.localizedDescription)
            return
        }
        do{
            let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? jsonStandard
            
            if let hits = dict?["hits"] as? [jsonStandard]{
                
                for x in 0..<hits.count{
                    if let recipe = hits[x]["recipe"] as! jsonStandard!{
                        let image = recipe["image"] as? String
                        let name = recipe["label"] as? String
                        let healthLabels = recipe["healthLabels"] as? Array<String>
                        let ingredients = recipe["ingredientLines"] as? Array<String>
                        let calories = recipe["calories"] as? Int
                        let servings = recipe["yield"] as? Int
                        
                        let recipe = Recipe(image: image!, name: name!, healthLabels: healthLabels!, ingredients: ingredients!, calories: calories!, servings: servings!)
                        listOfRecipies.append(recipe)
                    }
                }
            print(listOfRecipies)
            }
        } catch let jsonError {
            print("ERROR \(jsonError)")
        }
    }.resume()
}
