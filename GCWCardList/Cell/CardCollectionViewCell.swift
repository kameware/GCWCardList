//
//  CardCollectionViewself.swift
//  CWCards
//
//  Created by nakamura on 2015/11/12.
//  Copyright © 2015年 Mineharu. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardNoLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var abilyty1Label: UILabel!
    @IBOutlet weak var ability2Label: UILabel!
    @IBOutlet weak var atkLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var illustratorLabel: UILabel!
    @IBOutlet weak var recordingLabel: UILabel!
    
    func setCardInfo (card:Card, number:Int) {
        
        // 各パラメータをセルにセット
        self.cardNoLabel.text = NSString(format: "No.:%@", (card.card_number)) as String
        self.cardNameLabel.text = NSString(format: "カード名:%@", (card.card_name)) as String
        let attrText = NSMutableAttributedString(string: NSString(format: "コスト: %@:%@ 無色:%@", (card.color_restraint_1), (card.color_restraint_2), (card
            .cost)) as String)
        if card.type != "4" && card.type != "5" {
            attrText.addAttribute(NSForegroundColorAttributeName, value: GCWUtils.getCardColor(card.color), range: NSMakeRange(4, 4))
            attrText.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(9, 4))
        }
        
        
        self.costLabel.attributedText = attrText
        self.abilyty1Label.text = NSString(format: "能力１:%@", (card.ability_1)) as String
        self.ability2Label.text = NSString(format: "能力２:%@", (card.ability_2)) as String
        self.atkLabel.text = NSString(format: "ATK:%@", (card.atk)) as String
        self.defLabel.text = NSString(format: "DEF:%@", (card.def)) as String
        self.elementLabel.text = NSString(format: "特徴:%@", (card.element)) as String
        self.sizeLabel.text = NSString(format: "サイズ:%@", (card.size)) as String
        self.colorLabel.text = NSString(format: "色:%@", (card.color)) as String
        self.rarityLabel.text = NSString(format: "レアリティ:%@", (card.rarity)) as String
        self.illustratorLabel.text = NSString(format: "イラストレーター:%@", (card.illustrator)) as String
        self.recordingLabel.text = NSString(format: "収録:%@", (card.recording)) as String
        self.cardImageView.sd_setImageWithURL(NSURL(string: card.url))
        self.cardImageView.backgroundColor = GCWUtils.getCardColor(card.color)
        
        // ラベルの文字サイズ調整
        self.abilyty1Label.adjustsFontSizeToFitWidth = true
        self.ability2Label.adjustsFontSizeToFitWidth = true
        self.illustratorLabel.adjustsFontSizeToFitWidth = true
        self.recordingLabel.adjustsFontSizeToFitWidth = true
    }
}
