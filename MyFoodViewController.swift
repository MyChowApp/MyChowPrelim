//
//  MyFoodViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/15/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class MyFoodViewController: UITableViewController {

    var myTableView = [String]()
    var mealDataList = MyMealData.fetchMealbyName("")
    var selectedMeal:String!
    
    @IBOutlet var myTableViewControl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Detect hand gesture for side bar menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // get the total number of meals from the database
        for aMeal in mealDataList{
            myTableView.append(aMeal.Name)
        }
        
        // create custom identifier for each cell
        for i in myTableView{
            myTableViewControl.registerClass(UITableViewCell.self, forCellReuseIdentifier: i)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableView.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myTableView[indexPath.row] , forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = myTableView[indexPath.row] as String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedMeal = myTableView[indexPath.row]
        print(selectedMeal)
        self.performSegueWithIdentifier("myFoodView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC:MyEachFoodViewController = segue.destinationViewController as! MyEachFoodViewController
        destinationVC.foodName = selectedMeal
    }
}
