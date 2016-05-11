//
//  GCWUtils.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/10.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit

class GCWUtils: NSObject {

    static func getCardColor(color: String) -> UIColor {
        
        var cardColor = UIColor.lightGrayColor()
        switch (color) {
        case "青":
            cardColor = UIColor.blueColor()
            break
        case "緑":
            cardColor = UIColor.greenColor()
            break
        case "黄":
            cardColor = UIColor.orangeColor()
            break
        case "黒":
            cardColor = UIColor.blackColor()
            break
        case "赤":
            cardColor = UIColor.redColor()
            break
        default:
            break
        }
        return cardColor
    }
    
    static func IntToStringCount(count: Int) -> String {
        
        var countStr = ""
        switch (count) {
        case 1:
            countStr = "①"
            break
        case 2:
            countStr = "②"
            break
        case 3:
            countStr = "③"
            break
        case 4:
            countStr = "④"
            break
        case 5:
            countStr = "⑤"
            break
        case 6:
            countStr = "⑥"
            break
        case 7:
            countStr = "⑦"
            break
        case 8:
            countStr = "⑧"
            break
        case 9:
            countStr = "⑨"
            break
        default:
            break
        }
        return countStr
    }
}
