//
//  UnitFieldView.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/17.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import DNDDragAndDrop

class UnitFieldView: UIView, DNDDropTargetDelegate {
    
    var card: Card = Card()
    
    override func awakeFromNib() {
        
    }
    
    // MARK: - DropTargetDelegate
    
    /**
     Viewの領域に被った時
     
     - parameter operation: ドラッグしてるもの
     - parameter target:    ドロップ対象
     */
    func dragOperation(operation: DNDDragOperation, didDropInDropTarget target: UIView) {
        print("dragOperation didDropInDropTarget")
    }
    
    /**
     ドロップした時
     
     - parameter operation: ドラッグしてるもの
     - parameter target:    ドロップ対象
     */
    func dragOperation(operation: DNDDragOperation, didEnterDropTarget target: UIView) {
        print("dragOperation didEnterDropTarget")
        let cardView = target as! CardView
        self.card = cardView.card
    }
    
    /**
     離れた時？
     
     - parameter operation: ドラッグしてるもの
     - parameter target:    ドロップ対象
     */
    func dragOperation(operation: DNDDragOperation, didLeaveDropTarget target: UIView) {
        print("dragOperation didLeaveDropTarget")
    }

}
