//
//  ProfileController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/6/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import CoreData

class ProfileController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var bDayLabel: UILabel!
    @IBOutlet var allergiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loading user's profile entity from core data
        loadUserProfile()
        loadUserFilter()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadUserProfile(){
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        let results:NSArray = try! context.executeFetchRequest(request)
        
        if(results.count > 0){
            for item in results as! [NSManagedObject]{
                nameLabel.text = "Full Name: \(item.valueForKey("firstName")!) \(item.valueForKey("lastName")!)"
                emailLabel.text = "E-Mail: \(item.valueForKey("email")!)"
                bDayLabel.text = "Date of Birth: \(item.valueForKey("birthDay")!)"
            }
        }else{
            print("0 Results Returned...  Potential Error.")
        }

    }
    
    func loadUserFilter(){
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Filter")
        request.returnsObjectsAsFaults = false
        
        let results:NSArray = try! context.executeFetchRequest(request)
        
        if(results.count > 0){
            for item in results as! [NSManagedObject]{
                allergiesLabel.text = "\(item.valueForKey("fish")!), \(item.valueForKey("shrimp")!), \(item.valueForKey("glutenfree")!), \(item.valueForKey("nongmo")!)"
                print(item)
            }
        }else{
            print("0 Results Returned...  Potential Error.")
        }

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
