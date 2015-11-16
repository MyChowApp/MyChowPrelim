//
//  ProfSetUpController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ProfSetUpController: UIViewController, UITextFieldDelegate {

    @IBOutlet var firstNField: UITextField!
    @IBOutlet var lastNField: UITextField!
    @IBOutlet var eAddressField: UITextField!
    @IBOutlet var foodFilterField: UITextField!
    @IBOutlet var personalGoalField: UITextField!
    
    @IBOutlet var bDayPicker: UIDatePicker!
    var bDayStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Date picker reads input when value changed
    @IBAction func bDaySelected(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let strDate = dateFormatter.stringFromDate(bDayPicker.date)
        
        bDayStr = strDate
    }
    
    @IBAction func proceedToNextScreen(sender: UIButton) {
        if firstNField.text == "" || lastNField.text == "" || eAddressField.text == "" || bDayStr == "" || foodFilterField.text == "" || personalGoalField.text == "" {
            
            print("Missing Information...")
            
        }else{
            let myChowUser = UserProfile(firstName: firstNField.text!, lastName: lastNField.text!, dob: bDayStr, email: eAddressField.text!, goals: personalGoalField.text!, foodFilter: foodFilterField.text!)
            // Get the default Realm
            let realm = try! Realm()
            // You only need to do this once (per thread)
            
            // Add to the Realm inside a transaction
            try! realm.write {
                realm.add(myChowUser)
                
                print("Write to Realm successfully!")
                try! print(Realm().path)
            }
            // initialize food database
            MealData.initialize()
     
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


