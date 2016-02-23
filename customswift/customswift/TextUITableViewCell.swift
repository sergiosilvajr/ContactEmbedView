//
//  TextUITableViewCell.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 2/23/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//

import UIKit

class TextUITableViewCell: UITableViewCell {

    var label: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.label = UILabel(frame: CGRectMake(5,10,300,50))
        self.addSubview(self.label)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.label = UILabel(frame: CGRectMake(5,10,300,50))
        self.addSubview(self.label)

    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
