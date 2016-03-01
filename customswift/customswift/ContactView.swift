//
//  ContactView.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 2/29/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//

import UIKit

class ContactView : UIView {
    var name: UILabel!
    var firstLetter : UILabel!
    var image: UIImageView!
    var closeButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    func initView(){
        self.backgroundColor = UIColor.lightGrayColor()
        
        firstLetter = UILabel(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 30, height: 30))
        firstLetter.textAlignment = NSTextAlignment.Center
        firstLetter.backgroundColor = Utils.getRandomColor()
        name = UILabel(frame: CGRect(x: bounds.origin.x + firstLetter.bounds.width+10, y: bounds.origin.y, width: frame.size.width/2, height: 30))
        
        firstLetter.layer.cornerRadius = firstLetter.frame.size.width/2
        firstLetter.layer.masksToBounds = true
        
        image = UIImageView(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 30, height: 30))
        closeButton = UIButton(frame: CGRect(x: bounds.origin.x + firstLetter.bounds.width + name.bounds.width , y: bounds.origin.y, width: 30, height: 30))
        closeButton.setTitle("X", forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "clickOnCloseButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(firstLetter)
        self.addSubview(name)
        self.addSubview(image)
        self.addSubview(closeButton)
    }
    
    func clickOnCloseButton(sender: UIButton){
        print("closed contact View")
        (self.superview as! AutoCompleteTextView).textField?.text=""
         (self.superview as! AutoCompleteTextView).paramString=""
        (self.superview as! AutoCompleteTextView).contactView = nil
        self.removeFromSuperview()
        self.hidden = true
    }
       
}
