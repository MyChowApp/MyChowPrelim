//
//  FilterBackTableViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/15/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import Foundation

class FilterBackTableViewController: UITableViewController, CheckboxDelegate {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mCheckboxTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mCheckboxTitles[indexPath.row] as! String, forIndexPath: indexPath) as UITableViewCell
        
//        cell.textLabel?.text = mCheckboxTitles[indexPath.row] as? String
        
        return cell
    }
    var mCheckboxTitles = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mCheckboxTitles = ["Gluten-Free", "Vegan", "Chicken", "Shrimp", "Asparagus"];
        self.createCheckboxes(5);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createCheckboxes(numberOfCheckBoxes: Int) {
        let lNumberOfCheckboxes = numberOfCheckBoxes;
        let lCheckboxHeight: CGFloat = 44.0;
        // #2
        var lFrame = CGRectMake(0, 44, self.view.frame.size.width, lCheckboxHeight);
        
        for (var counter = 0; counter < lNumberOfCheckboxes; counter++) {
            // #3
            let lCheckbox = Checkbox(frame: lFrame, title: self.mCheckboxTitles[counter] as! String, selected: false);
                lCheckbox.mDelegate = self;
                lCheckbox.tag = counter;
            
            self.view.addSubview(lCheckbox);
            // #4
            lFrame.origin.y += lFrame.size.height;
        }
    }
    
    // #5
    func didSelectCheckbox(state: Bool, identifier: Int, title: String) {
        print("checkbox '\(title)' has state \(state)");
    }
}