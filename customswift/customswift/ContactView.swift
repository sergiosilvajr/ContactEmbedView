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
        
        firstLetter = UILabel(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 30, height: 30))
        firstLetter.textAlignment = NSTextAlignment.Center
        firstLetter.backgroundColor = getRandomColor()
        name = UILabel(frame: CGRect(x: bounds.origin.x + firstLetter.bounds.width, y: bounds.origin.y, width: 30, height: 30))
        
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
        print("closed")
        self.removeFromSuperview()
        self.hidden = true
    }
    
    private func getRandomColor() -> UIColor{
        var color: UIColor
        let result = Int.random(0...5)
        switch result{
        case 1:
            color = UIColor.greenColor()
            break
        case 2:
             color = UIColor.whiteColor()
            break
        case 3:
             color = UIColor.blueColor()
            break
        case 4:
             color = UIColor.magentaColor()
            break
        case 5:
             color = UIColor.yellowColor()
            break
        default:
            color = UIColor.redColor()
            break
        }
         return color
    }
    
}
