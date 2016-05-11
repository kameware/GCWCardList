//
//  Card.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/02.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    
    dynamic var ability_1           = ""
    dynamic var ability_2           = ""
    dynamic var atk                 = ""
    dynamic var card_name           = ""
    dynamic var card_number         = ""
    dynamic var card_type           = ""
    dynamic var color               = ""
    dynamic var color_restraint_1   = ""
    dynamic var color_restraint_2   = ""
    dynamic var cost                = ""
    dynamic var counter             = ""
    dynamic var created_at          = ""
    dynamic var def                 = ""
    dynamic var element             = ""
    dynamic var id                  = ""
    dynamic var illustrator         = ""
    dynamic var model_number        = ""
    dynamic var open                = ""
    dynamic var rarity              = ""
    dynamic var recording           = ""
    dynamic var size                = ""
    dynamic var total_cost          = ""
    //! 1: ユニット, 2: イベント, 3: カウンター, 4: クルー, 5: パイロット
    dynamic var type                = ""
    dynamic var updated_at          = ""
    dynamic var url                 = ""
    var expantion: Expantion {
        return linkingObjects(Expantion.self, forProperty: "cards").first!
    }
    
    
    override static func primaryKey() -> String? {
        return "card_number"
    }
    
}
