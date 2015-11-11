//
//  InitialViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This method checks whether this app has been launched before on this device.  If it has not, then the user will be prompted to enter their health information at a setup wizard, else the app will launch the regular interface
    override func viewDidAppear(animated: Bool) {
        //NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch") returns a boolean value whether this application has been launched before on this device.
        let haveLaunched = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        // case haveLaunched == true
        if haveLaunched  {
            print("Not first launch.", terminator: "")
        self.performSegueWithIdentifier("masterTabView", sender: self)
        }
        // case haveLaunched == false
        else {
            print("First launch, setting NSUserDefault.", terminator: "")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            self.performSegueWithIdentifier("setUpWizView", sender: self)
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
