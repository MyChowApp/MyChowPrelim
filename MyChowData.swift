//
//  MyChowData.swift
//
//  Created by Xingwei Liu on 15/11/14.
//  Copyright © 2015 Xingwei Liu. All rights reserved.
//


//Data obtain from parsing
//MealData.addMeal(Meal(value:["Name":"Tostadas", "ID":1, "Ingredient":foods, "Rate":4, "img":"http://d1wcgy4dy6voh7.cloudfront.net/wp-content/uploads/2015/06/IMG_2015_06_26_05310.jpg"]))

import Foundation
import RealmSwift

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

class Meal: Object
{
    dynamic var Name: String = ""
    dynamic var ID: Int = 0
    var Ingredients = List<Food>()
    dynamic var Rate: Int = 5
    dynamic var img: String = ""
    
    override static func primaryKey() -> String?
    {
        return "ID"
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Meal
        {
            return object.ID == ID
        }
        else
        {
            return false
        }
    }
    override var hash: Int {
        return ID.hashValue
    }
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
        var result = meals.map { $0 }
        var tmp: Array<Meal> = []
        for i in result
        {
            if(Set<Food>(i.Ingredients).intersect(Set<Food>(mf.NotEatingFoods)).isEmpty)
            {
                tmp.append(i)
            }
        }
        result = []
        for i in tmp
        {
            if(!Set<Food>(i.Ingredients).intersect(Set<Food>(mf.MustEatingFoods)).isEmpty)
            {
                result.append(i)
            }
        }

        return result
    }
}
