//
//  SetUpFilterController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import CoreData

class SetUpFilterController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var fishCB: CheckBox!
    @IBOutlet var shCB: CheckBox!
    @IBOutlet var gfCB: CheckBox!
    @IBOutlet var nonGMOCB: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize.height = 1000
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function launch the main interface page with the status of filter recorded into the app's coredata
    @IBAction func wizDoneAction(doneClicked: UIButton) {
        //recording to coredata's entity, 'Filter' based on each filter's status
        
        //load entity from coredata
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Filter",
            inManagedObjectContext:managedContext)
        let info = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //set values to entity
        if fishCB.getCheckStatus(){
            info.setValue("fish", forKey: "fish")// fish filter added
        }else{
            info.setValue("", forKey: "fish")
        }
        if shCB.getCheckStatus(){
            info.setValue("shrimp", forKey: "shrimp")// shrimp filter added
        }
        else{
            info.setValue("", forKey: "shrimp")
        }
        if gfCB.getCheckStatus(){
            info.setValue("glutenfree", forKey: "glutenfree")// glutenfree filter added
        }
        else{
            info.setValue("", forKey: "glutenfree")
        }
        if nonGMOCB.getCheckStatus(){
            info.setValue("nongmo", forKey: "nongmo")
        }
        else{
            info.setValue("", forKey: "nongmo")
        }
        
        // try catch an exception
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        //proceed to the next screen
        let mainStoryboard = UIStoryboard(name: "Main", bundle:     NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainTabBarController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)

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