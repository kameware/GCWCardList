//
//  DeckView.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/17.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import DNDDragAndDrop
import SDWebImage

/**
 * デッキ管理View
 */
class DeckView: UIView, DNDDragSourceDelegate, DNDDropTargetDelegate {
    
    var deckArray = Array<Card>()
    
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    // MARK: - DNDDragSourceDelegate
    func draggingViewForDragOperation(operation: DNDDragOperation) -> UIView? {
        // デッキに残り枚数があるなら処理
        if (0 < deckArray.count) {
            let cardView = CardView(frame: operation.draggingView.frame)
            cardView.card = self.deckArray.popLast()!;
            cardView.cardImageView.sd_setImageWithURL(NSURL(string: cardView.card.url))
            return cardView
            
        }
        
        return nil;
    }
    
    
    // MARK: - DNDDropTargetDelegate
    /**
     ドロップ時の操作
     
     - parameter operation: ドラッグ
     - parameter target:    ドロップ
     */
    func dragOperation(operation: DNDDragOperation, didDropInDropTarget target: UIView) {
        let cardView = target as! CardView
        self.deckArray.append(cardView.card)
    }

}
