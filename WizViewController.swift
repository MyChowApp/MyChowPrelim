//
//  WizViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class WizViewController: UIViewController {

    @IBOutlet var greetingMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingMessage.adjustsFontSizeToFitWidth = true
        
        greetUsers(4, message: "We're here to help you make the right food choices.")
        greetUsers(8, message: "Whereever you are.  Whoever you are.")
        greetUsers(12, message: "Now, let us know a little bit about yourself!")
        
        
        // Change greetingMessage.text as a welcoming message.  Each interval will display different messages and lastly, this block of code will bring the user to a setup screen.
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 16 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //launch the setup screen for users to input their information
            self.performSegueWithIdentifier("signUpView", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // local function that will change the screen label according to an assigned message.
    func greetUsers(timeInterval: Int64 , message: String){
        // Change greetingMessage.text as a welcoming message.  Each interval will display different messages and lastly, this block of code will bring the user to a setup screen.
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), timeInterval * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //perform code here
            self.greetingMessage.text = message
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
