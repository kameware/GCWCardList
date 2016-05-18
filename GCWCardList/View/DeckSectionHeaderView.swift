//
//  DeckSectionHeaderView.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/18.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit

class DeckSectionHeaderView: UIView {

    @IBOutlet weak var sectionLabel: UILabel!
    
    var addCard:(() -> ())?

    /**
     追加ボタン押下時
     
     - parameter sender: +ボタン
     */
    @IBAction func addCardAction(sender: AnyObject) {
        addCard!()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = NSBundle.mainBundle().loadNibNamed("DeckSectionHeaderView", owner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
