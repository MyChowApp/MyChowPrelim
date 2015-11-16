//
//  MyEachFoodViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/16/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import Foundation

class MyEachFoodViewController: UIViewController{
    @IBOutlet var showRecipeImage: UIImageView!
    @IBOutlet var showRecipeName: UILabel!
    @IBOutlet var recipeContent: UITextView!
    
    
    
    var foodName:String!
    var img:String!
    var ingredients:String!
    var instruction:String!
    var primaryIDKey:Int!
    
    @IBAction func removeFromMyFood(sender: UIButton) {
        MyMealData.removeMealbyName(foodName)
        
        print("Remove from MyMeal successfully")
//        //proceed to the next screen
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MyFoodController") as UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
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
        }
        
        
        recipeContent.text = "\(ingredients!)\n\nInstructions: \(instruction!)"
        
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