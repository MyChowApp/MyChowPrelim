//
//  ViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/6/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var hashMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // load side bar menu
        hashMenuButton.target = self.revealViewController()
        hashMenuButton.action = Selector("revealToggle:")
        
        //Detect hand gesture for side bar menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

