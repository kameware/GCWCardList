//
//  Deck.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/18.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import Foundation
import RealmSwift

class Deck: Object {
    
    dynamic var id   = 0
    dynamic var name = ""
    var cards        = List<Card>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
