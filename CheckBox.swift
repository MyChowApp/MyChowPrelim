//
//  CheckBox.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/8/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import UIKit

//class CheckBox: UIButton {
//    // Images
//    let checkedImage = UIImage(named: "checked_checkbox")! as UIImage
//    let uncheckedImage = UIImage(named: "unchecked_checkbox")! as UIImage
//    
//    // Bool property
//    var isChecked: Bool = false {
//        didSet{
//            if isChecked == true {
//                self.setImage(checkedImage, forState: .Normal)
//            } else {
//                self.setImage(uncheckedImage, forState: .Normal)
//            }
//        }
//    }
//    
//    override func awakeFromNib() {
//        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.isChecked = false
//    }
//    
//    func buttonClicked(sender: UIButton) {
//        if sender == self {
//            if isChecked == true {
//                isChecked = false
//            } else {
//                isChecked = true
//            }
//        }
//    }
//    
//    func getCheckStatus()-> Bool{
//        if isChecked{
//            return true
//        }
//        else{
//            return false
//        }
//    }
//}

class Checkbox : UIButton {
    var mDelegate: CheckboxDelegate?;
    // #1
    required init(coder: NSCoder) {
        super.init(frame: CGRectZero);
    }
    
    // #2
    init(frame: CGRect, title: String, selected: Bool) {
        super.init(frame: frame);
        self.adjustEdgeInsets();
        self.applyStyle();
        self.setTitle(title, forState: UIControlState.Normal);
        self.addTarget(self, action: "onTouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    func adjustEdgeInsets() {
        let lLeftInset: CGFloat = 8.0;
        // #3
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        // #4
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0 as CGFloat, lLeftInset, 0.0 as CGFloat, 0.0 as CGFloat);
        // #5
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0 as CGFloat, (lLeftInset * 2), 0.0 as CGFloat, 0.0 as CGFloat);
    }
    
    // #6
    func applyStyle() {
        self.setImage(UIImage(named: "checked_checkbox"), forState: UIControlState.Selected);
        self.setImage(UIImage(named: "unchecked_checkbox"), forState: UIControlState.Normal);
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
    }
    
    func onTouchUpInside(sender: UIButton) {
        // #7
        self.selected = !self.selected;
        // #8
        mDelegate?.didSelectCheckbox(self.selected, identifier: self.tag, title: self.titleLabel!.text!);
    }
}
