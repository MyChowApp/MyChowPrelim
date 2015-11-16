//
//  RecipesController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/14/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class RecipesController: UIViewController {
    
    @IBOutlet var tableView: MyChowTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Detect hand gesture for side bar menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
}
