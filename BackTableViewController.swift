//
//  BackTableViewController.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/11/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import Foundation

class BackTableViewController: UITableViewController {
    
    var tableArray = [String]()
    
    override func viewDidLoad() {
        tableArray = ["Chow","Profile", "Journal"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
        
        return cell
    }
}