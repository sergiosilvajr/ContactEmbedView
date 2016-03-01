//
//  StringExtension.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 2/29/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//

import Foundation

extension String {
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self.characters {
            if cur == index {
                return char
            }
            cur++
        }
        return nil
    }
    
    func startsWith(string: String) -> Bool {
        
        guard let range = rangeOfString(string, options:[.AnchoredSearch, .CaseInsensitiveSearch]) else {
            return false
        }
        
        return range.startIndex == startIndex
    }
}