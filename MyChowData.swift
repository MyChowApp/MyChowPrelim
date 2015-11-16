//
//  MyChowData.swift
//
//  Created by Xingwei Liu on 15/11/14.
//  Copyright © 2015 Xingwei Liu. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

let realm = try! Realm()

class Text: Object {
    dynamic var content = ""
    dynamic var id = 1
    convenience required init(str: String?){
        self.init()
        content = str!
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Food: Object,Hashable
{
    dynamic var Name: String = ""
    dynamic var ID: Int = 0
    dynamic var Unit: String = "g"
    
    dynamic var Amount: Int = -1
    
    override static func primaryKey() -> String?
    {
        return "ID"
    }
    
    override var hashValue: Int {
        return self.ID
    }
    
}

func ==(lhs:Food, rhs:Food) -> Bool {
    return lhs.ID == rhs.ID
}

class PersonalProfile: Object
{
    dynamic var Gender: Int = 0 //0=Male 1=Female
    dynamic var Name: String = ""
    var NotEatingFoods = List<Food>()
    
    //Optional
    var Age: Int?
    var Weight: Double?
    var Height: Double?
}


class Meal: Object, Hashable
{
    dynamic var Name: String = ""
    dynamic var ID: Int = 0
    dynamic var Ingredients: String = ""
    dynamic var Rate: Int = 0
    dynamic var EatOut: Bool = false
    dynamic var Catagory: String = ""
    dynamic var CookTime: String = ""
    dynamic var PrepTime: String = ""
    dynamic var TotalTime: String = ""
    dynamic var Notes: String = ""
    dynamic var Others: String = ""
    dynamic var OthersName: String = ""
    dynamic var img: String = ""
    override static func primaryKey() -> String?
    {
        return "ID"
    }
    
    override var hashValue: Int {
        return self.ID
    }
}

func ==(lhs:Meal, rhs:Meal) -> Bool {
    return lhs.ID == rhs.ID
}

class FoodData
{
    
    static func fetchFoodbyName(name: String) -> [Food]
    {
        return realm.objects(Food).filter("Name CONTAINS[c] '"+name.lowercaseString+"'").map { $0 }
    }
    
    static func fetchFoodbyID(ID: Int) -> Food?
    {
        return realm.objects(Food).filter("ID == "+String(ID)).first
    }
    
    static func addFood(f: Food)
    {
        try! realm.write {
            realm.add(f, update: true)
        }
    
    }
}

class MealData
{
    
    class MealFilter
    {
        var NotEatingFoods: [Food] = []
        var MustEatingFoods: [Food] = []
        var MinimalRating: Int = 0
        var MaximumRating: Int = 5
    }
    
    static func fetchMealbyName(name: String) -> [Meal]
    {
        return realm.objects(Meal).filter("Name CONTAINS[c] '"+name.lowercaseString+"'").map { $0 }
    }
    
    static func fetchMealbyID(ID: Int) -> Meal?
    {
        return realm.objects(Meal).filter("ID == "+String(ID)).first
    }
    
    static func addMeal(m: Meal)
    {
        try! realm.write {
            realm.add(m, update: true)
        }
    }
    
    static func removeMealbyName(name: String) -> [Meal]
    {
        let meals = fetchMealbyName(name)
        try! realm.write {
            for m in meals
            {
                realm.delete(m)
            }
        }
        return meals
    }
    
    static func removeMealbyID(ID: Int) -> Meal?
    {
        let meal = fetchMealbyID(ID)
        try! realm.write {
            realm.delete(meal!)
        }
        return meal
    }
    
    static func fetchMealbyFilter(mf: MealFilter) -> [Meal]
    {
        
        var meals = realm.objects(Meal)
        meals = meals.filter("Rate >= "+String(mf.MinimalRating))
        meals = meals.filter("Rate <= "+String(mf.MaximumRating))
        for i in mf.NotEatingFoods
        {
            meals = meals.filter("NOT Others CONTAINS[c] "+i.Name)
        }
        for i in mf.MustEatingFoods
        {
            meals = meals.filter("Others CONTAINS[c] "+i.Name)
        }

        return meals.map { $0 }
    }
}


