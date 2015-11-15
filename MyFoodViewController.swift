//
//  MyFoodViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/15/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

class MyFoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
}
