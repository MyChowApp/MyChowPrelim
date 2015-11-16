//
//  PeriodController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/6/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import MessageUI

class PeriodController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bDayLabel: UILabel!
    @IBOutlet var allergiesLabel: UILabel!
    @IBOutlet var myScrollView: UITextView!
    @IBOutlet var hashMenuButton: UIBarButtonItem!
    
    @IBAction func exportPDFAction(sender: UIBarButtonItem) {
        let textToShare = "Swift is awesome!  Check out this website about it!"
//        
//        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
//        {
//            let objectsToShare = [textToShare, myWebsite]
            let objectsToShare = [textToShare]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! print(Realm().path)

        // load user info.
        var name:String!
        var bDay:String!
        var foodFilter:String!
        let userInfo = realm.objects(UserProfile)
        for i in userInfo{
            name = i.fullName
            bDay = i.dob
            foodFilter = i.foodFilter
        }
        // load food data
        var recipes = [String]()
        var ingredients = [String]()
        var dates = [String]()
        
        let foodData = realm.objects(MyMeal)
        for i in foodData{
            recipes.append(i.Name)
            ingredients.append(i.Ingredients)
            dates.append(i.Date)
        }
        
        
        for i in dates{
            let foodDatabyDate = MyMealData.fetchMealbyDate(i)
            myScrollView.text = "\n\n\(myScrollView.text)\n\(i)\n\n"
            for j in foodDatabyDate{
                myScrollView.text =
                "\(myScrollView.text)\n\n\n\(j.Name)\n\n\(j.Ingredients)"
            }
            
        }
        
        
        
        let myObj = JournalGenerator.self
        myObj.drawPDF(name, secondStr: bDay, thirdStr: foodFilter, firstList: recipes, secondList: ingredients, thirdList: dates)
        nameLabel.text = name
        bDayLabel.text = bDay
        allergiesLabel.text = foodFilter
        
        
        
        

        // Do any additional setup after loading the view.
        //this button invokes side menu bar
        hashMenuButton.target = self.revealViewController()
        hashMenuButton.action = Selector("revealToggle:")
        
        //Detect hand gesture for side bar menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
