//
//  ApiRequest.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/22/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

class ApiService: NSObject{
    
    static let sharedInstance = ApiService()
    
    var listOfRecipies: [Recipe]?
    
    let Increment = 100
    
    let query = "pizza"
    
    func downloadRecipe(completionHandler: @escaping DownloadComplete){
        
        typealias jsonStandard = Dictionary<String,AnyObject>
        
        //if let this
        let url = URL(string: "https://api.edamam.com/search?q=\(query)&app_id=6a18017d&app_key=56b29c7fe0addda91493a8cb0f9d0e73&from=0&to=\(Increment)")
        
        let urlRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            do{
                let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? jsonStandard
                
                self.listOfRecipies = [Recipe]()
                
                if let hits = dict?["hits"] as? [jsonStandard]{
                    
                    for x in 0..<hits.count{
                        
                        if let recipe = hits[x]["recipe"] as! jsonStandard!{
                            
                            let image = recipe["image"] as? String
                            let name = recipe["label"] as? String
                            let healthLabels = recipe["healthLabels"] as? Array<String>
                            let ingredients = recipe["ingredientLines"] as? Array<String>
                            let calories = recipe["calories"] as? Int
                            let servings = recipe["yield"] as? Int
                            let recipeUrl = recipe["url"] as? String
                            
                            let recipe = Recipe(image: image!, name: name!, healthLabels: healthLabels!, ingredients: ingredients!, calories: calories!, servings: servings!, recipeUrl: recipeUrl!)
                            
                            self.listOfRecipies?.append(recipe)
                            
                        }
                    }
                    DispatchQueue.main.async(execute: {
                        //safely unwrap
                        completionHandler(self.listOfRecipies!)
                        
                    })
                }
            } catch let jsonError {
                print("ERROR \(jsonError)")
            }
            }.resume()
    }
    
    
    var offset = 100
    
    var reachedEndOfItems = false
    
    func downloadMore(completionHandler: @escaping DownloadComplete){
        
        guard !reachedEndOfItems else{
            return
        }
        
        typealias jsonStandard = Dictionary<String,AnyObject>
        
        let itemsPerBatch = offset + Increment
        
        //if let this
        let url = URL(string: "https://api.edamam.com/search?q=\(query)&app_id=6a18017d&app_key=56b29c7fe0addda91493a8cb0f9d0e73&from=\(offset)&to=\(itemsPerBatch)")
        
        let urlRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print(error)
                return
            }
            
            do{
                let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? jsonStandard
                
                
                if let hits = dict?["hits"] as? [jsonStandard]{
                    
                    for x in 0..<hits.count{
                        
                        if let recipe = hits[x]["recipe"] as! jsonStandard!{
                            
                            let image = recipe["image"] as? String
                            let name = recipe["label"] as? String
                            let healthLabels = recipe["healthLabels"] as? Array<String>
                            let ingredients = recipe["ingredientLines"] as? Array<String>
                            let calories = recipe["calories"] as? Int
                            let servings = recipe["yield"] as? Int
                            let recipeUrl = recipe["url"] as? String
                            
                            let recipe = Recipe(image: image!, name: name!, healthLabels: healthLabels!, ingredients: ingredients!, calories: calories!, servings: servings!, recipeUrl: recipeUrl!)
                            
                            self.listOfRecipies?.append(recipe)
                            
                        }
                    }
                    
                    DispatchQueue.main.async(execute: {
                        
                        print("FROM \(self.offset)")
                        
                        self.offset += self.Increment
                        
                        print("TO \(self.offset)")
                        
                        if self.offset > (self.listOfRecipies?.count)!{
                            print("OFFSET \(self.offset) PASSES LIMIT \(self.listOfRecipies?.count)")
                            self.reachedEndOfItems = true
                        }
                        
                        
                        //safely unwrap
                        completionHandler(self.listOfRecipies!)
                        
                        
                    })
                }
            } catch let jsonError {
                print("OH NOO ERROR \(jsonError.localizedDescription)")
            }
            }.resume()
    }
    
}

