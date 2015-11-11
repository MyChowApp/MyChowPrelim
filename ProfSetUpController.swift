//
//  ProfSetUpController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import CoreData

class ProfSetUpController: UIViewController, UITextFieldDelegate {
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var firstNField: UITextField!
    @IBOutlet var lastNField: UITextField!
    @IBOutlet var eAddressField: UITextField!
    
    @IBOutlet var bDayPicker: UIDatePicker!
    var bDayStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstNField.delegate = self
        self.lastNField.delegate = self
        self.eAddressField.delegate = self
        scrollView.contentSize.height = 1000
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Date picker reads input when value changed
    @IBAction func bDaySelected(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.stringFromDate(bDayPicker.date)
        
        bDayStr = strDate
    }
    
    @IBAction func proceedToNextScreen(sender: UIButton) {
        if firstNField.text == "" || lastNField.text == "" || eAddressField.text == "" || bDayStr == ""{
            
            print("Missing Information...")
            
        }else{
            //load entity from coredata
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity =  NSEntityDescription.entityForName("User",
                inManagedObjectContext:managedContext)
            let info = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext: managedContext)
            
            //set values to entity
            info.setValue(firstNField.text!, forKey: "firstName")
            info.setValue(lastNField.text!, forKey: "lastName")
            info.setValue(eAddressField.text!, forKey: "email")
            info.setValue(bDayStr, forKey: "birthDay")
            
            // try catch an exception
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            //proceed to the next screen
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MessageController") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
