//
//  TextUITableViewCell.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 2/23/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//

import UIKit

class TextUITableViewCell: UITableViewCell {
    var currentImage: UIImageView!
    var label: UILabel!
    var firstLetterLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    func initView(){
        self.label = UILabel(frame: bounds)
        self.firstLetterLabel = UILabel(frame: bounds)
        self.currentImage = UIImageView(frame: bounds)
        self.addSubview(self.label)
        self.addSubview(self.firstLetterLabel)
        self.addSubview(self.currentImage)
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
