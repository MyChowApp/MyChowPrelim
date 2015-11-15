//
//  ProfileController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/6/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ProfileController: UIViewController {
    @IBOutlet var goalsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var bDayLabel: UILabel!
    @IBOutlet var allergiesLabel: UILabel!
    @IBOutlet var hashMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loading user's profile entity from Realm Database
        loadUserProfile()
        
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
    

    func loadUserProfile(){
        let userProf = try! Realm().objects(UserProfile)
        if userProf.count > 0{
            for user in userProf{
                nameLabel.text = "Full Name:    \(user.fullName!)"
                emailLabel.text = "Email Address:   \(user.email!)"
                bDayLabel.text = "Date of Birth:    \(user.dob!)"
                allergiesLabel.text = "Known Allergies, Intolerances, Prohibited Food:  \(user.foodFilter!)"
                goalsLabel.text = "Personal Goals:  \(user.goals!)"
            }
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
