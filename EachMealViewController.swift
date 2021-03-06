//
//  EachMealViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/15/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class EachMealViewController: UIViewController {
    

    @IBOutlet var showRecipeImage: UIImageView!
    @IBOutlet var showRecipeName: UILabel!
    @IBOutlet var recipeContent: UITextView!
    
    
    
    var foodName:String!
    var img:String!
    var ingredients:String!
    var instruction:String!
    var primaryIDKey:Int!
    var extraName:String!
    var extraContent:String!
    var notes:String!
    

    @IBAction func addTomMyMeal(sender: UIButton) {
        if primaryIDKey == nil {
            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var id = defaults.valueForKey("ID") as? Int
            if id == nil{
                id = 0
            }
            primaryIDKey = id

        }
        
        if MyMealData.fetchMealbyName(foodName).count == 0{
            let currentDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
            MyMealData.addMeal(MyMeal(value:["ID": primaryIDKey, "Ingredients":ingredients, "Name": foodName,"img":img, "Date": "\(currentDate)"]))
            
            print("Add to MyMeal successfully \(primaryIDKey)")
            primaryIDKey = primaryIDKey + 1
        }
        
        
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults() //This class     variable needs to be defined every class where you set or fetch values from NSUserDefaults
        defaults.setObject(primaryIDKey, forKey: "ID")
        defaults.synchronize() //Call when you're done editing all defaults for the method.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showRecipeName.text = foodName
        let meallist = MealData.fetchMealbyName(foodName)
        print("fetch successfully")
        for i in meallist{
            showRecipeName.text = i.Name
            img = i.img
            ingredients = i.Ingredients
            instruction = i.Instructions
            extraName = i.OthersName
            extraContent = i.Others
            notes = i.Notes
        }
        

        recipeContent.text = "\(ingredients!)\n\n\(extraName)\n\(extraContent)\n\n\(notes)\n\nInstructions: \(instruction!)"
        
        print("Begin of code")
        if let checkedUrl = NSURL(string: img) {
            showRecipeImage.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl)
        }
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
    }
    

    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL){
        print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
                self.showRecipeImage.image = UIImage(data: data)
            }
        }
    }
    
    
}
