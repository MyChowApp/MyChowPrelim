//
//  MessageController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class MessageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 5 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //launch the setup screen for users to input their information
            self.performSegueWithIdentifier("mainScreenView", sender: self)

        }
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
