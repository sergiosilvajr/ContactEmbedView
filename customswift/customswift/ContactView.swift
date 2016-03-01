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
        self.backgroundColor = UIColor.grayColor()
        
        firstLetter = UILabel(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 40, height: 30))
        firstLetter.textAlignment = NSTextAlignment.Center
        firstLetter.backgroundColor = Utils.getRandomColor()
        name = UILabel(frame: CGRect(x: bounds.origin.x + firstLetter.bounds.width, y: bounds.origin.y, width: 60, height: 30))
        
        firstLetter.layer.cornerRadius = firstLetter.frame.size.width/2
        firstLetter.layer.masksToBounds = true
        
        image = UIImageView(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 30, height: 30))
        closeButton = UIButton(frame: CGRect(x: bounds.origin.x + firstLetter.bounds.width + name.bounds.width , y: bounds.origin.y, width: 30, height: 30))
        closeButton.setTitle("x", forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "clickOnCloseButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(firstLetter)
        self.addSubview(name)
        self.addSubview(image)
        self.addSubview(closeButton)
    }
    
    func clickOnCloseButton(sender: UIButton){
        print("closed contact View")
        (self.superview as! AutoCompleteTextView).contactView = nil
        self.removeFromSuperview()
        self.hidden = true
    }
    
       
}
