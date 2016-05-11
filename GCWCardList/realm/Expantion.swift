//
//  Expantion.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/01.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import RealmSwift

class Expantion: Object {
    dynamic var expantion_id        = 0
    dynamic var expantion_type      = ""
    dynamic var expantion_number    = 0
    dynamic var max_number          = 0
    dynamic var pr_type             = ""
    dynamic var expantion_name      = ""
    dynamic var sort_number         = 0
    var cards                       = List<Card>()

    var expantion_key: String {
        return "\(expantion_type)-\(NSString(format: "%03d", expantion_number))"
    }

    override static func primaryKey() -> String? {
        return "expantion_id"
    }

    override static func indexedProperties() -> [String] {
        return ["expantion_type", "expantion_number"]
    }
}
