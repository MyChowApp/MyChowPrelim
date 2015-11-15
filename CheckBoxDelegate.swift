//
//  CheckBoxDelegate.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/15/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import Foundation

protocol CheckboxDelegate {
    // #1
    func didSelectCheckbox(state: Bool, identifier: Int, title: String);
}

