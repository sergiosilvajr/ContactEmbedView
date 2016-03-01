//
//  Utils.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 3/1/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//

import UIKit

class Utils{
    static func getRandomColor() -> UIColor{
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