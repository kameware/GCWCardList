//
//  APIManager.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/01.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class APIManager: NSObject {
    
    static let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
        "Cookie": "",
        "Origin": "GCWCardList",
        "Accept-Encoding": "gzip, deflate",
        "Accept-Language": "ja,en-US;q=0.8,en;q=0.6"
    ]
    static let realm = try! Realm()

    /**
     * APIからパック情報を取得して登録
     */
    static func getExpantionList() {
        Alamofire.request(.GET, "http://gcw.hapinaru.com/expantionList.json")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    // 成功時
                    if let json = response.result.value {
                        if 0 < json.count {
                            try! self.realm.write {
                                let result = (json as! NSDictionary)["Result"] as! NSArray
                                for expantion in result {
                                    // パック情報登録
                                    self.realm.create(Expantion.self, value: expantion, update: true)
                                }
                            }
                        }
                    }

                    break
                case .Failure(let error):
                    // 失敗時
                    print("getExpantionListError:\(error)")

                    break
                }
        }
    }
    
    static func getCardInfo(expantion: Expantion, cardNumber: String, index:NSInteger, success: (card: Card)->Void) {
        
        // PRならURL変更
        let prFlg = expantion.expantion_type == "PR"
        
        // URL
        let urlPath = "https://www.gundam-cw.com/mng/search_ajax.php"
        
        // パラメータ調整
        let parameters = [
            "number": cardNumber,
            "card_type": prFlg ? "3" : "1"
        ]
        
        // カード情報取得
        Alamofire.request(.POST, urlPath, parameters: parameters, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let json = response.result.value {
                        if 0 < json.count {
                            let cardInfo:NSDictionary = (json as! NSArray)[0] as! NSDictionary;
                            var card: Card = Card()
                            try! self.realm.write{
                                // カード情報登録
                                card = self.realm.create(Card.self, value: cardInfo, update: true)
                                card.url = self.createImageUrlString(expantion, number: index)
                                // expantionの子として登録
                                expantion.cards.append(card)
                            }
                            success(card: card)
                        }
                    }
                case .Failure(let error):
                    NSLog("%@", error)
                }
            }
    }
    
    /**
     カードURLを生成
     
     - parameter expantion: パック情報
     - parameter number:    カード番号(数字のみ
     
     - returns: カード情報URL<NSURL>
     */
    static func createImageUrlString(expantion:Expantion, number:NSInteger) -> String {
        var cardNumber = String(format: "%@%02d-%03d", expantion.expantion_type, expantion.expantion_number, number)
        var imageUrl = "https://www.gundam-cw.com/img/card/\(cardNumber).png"
        if (expantion.expantion_type == ("PR")) {
            cardNumber = String(format: "%@-%@%03d", expantion.expantion_type, expantion.pr_type, number)
            imageUrl = "https://www.gundam-cw.com/img/card/pr/\(cardNumber).png"
        }
        return imageUrl
    }
}
