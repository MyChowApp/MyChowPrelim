//
//  RecipesController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/14/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import RealmSwift

class RecipesController: UIViewController {
    
    //Data obtain from parsing

    FoodData.addFood(Food(value:["Name": "corn", "ID": 1, "Unit": "g", "Amount": 30]))
    FoodData.addFood(Food(value:["Name": "chipotle", "ID": 1, "Unit": "g", "Amount": 30]))
    
    var foods = FoodData.fetchFoodbyName("")

    MealData.addMeal(Meal(value:["Name":"Tostadas", "ID":1, "Ingredient":makeData, "Rate":4, "img":"http://d1wcgy4dy6voh7.cloudfront.net/wp-content/uploads/2015/06/IMG_2015_06_26_05310.jpg"]))

//    @IBOutlet var filterMenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        filterMenuButton.target = self.revealViewController()
//        filterMenuButton.action = Selector("rightRevealToggle:")
        
        //Detect hand gesture for side bar menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
}
