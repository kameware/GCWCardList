//
//  CardListViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/02.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

let CardListViewControllerStoryboardName = "CardListViewController"
let CardListViewControllerIdentifier = "CardListViewController"

class CardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    /// パック情報
    var expantion: Expantion!
    /// カードリスト
    var cardList : Results<Card>!
    /// 検索フラグ
    var filterFlg: Bool = false
    /// デッキ情報 ある場合はカード追加
    var deck: Deck!
    /// true:MSデッキ, false:クルーデッキ
    var msFlg = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        
        if ((self.expantion) != nil) {
            self.cardList = expantion.cards.sorted("card_number");
        } else {
            let realm = try! Realm()
            self.cardList = realm.objects(Card).sorted("id")
        }
        
        // ナビゲーションバーにボタン追加
        let filterButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(CardListViewController.showFilterView))
        self.navigationItem.setRightBarButtonItem(filterButton, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableView Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.expantion) != nil && !filterFlg) {
            return self.expantion.max_number
        }
        
        return self.cardList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CardListCell", forIndexPath: indexPath)
        
        let number = indexPath.row + 1
        
        if ((self.expantion) != nil) {
            // 画像URL生成
            var cardNumber = String(format: "%@%02d-%03d", expantion.expantion_type, expantion.expantion_number, number)
            if (expantion.expantion_type == ("PR")) {
                cardNumber = String(format: "%@-%@%03d", expantion.expantion_type, expantion.pr_type, number)
            }
            // 画像取得してキャッシュ
            cell.imageView?.image = UIImage(named: "loadimage")
            
            if indexPath.row < cardList.count {
                // カード情報が存在する場合
                let card = cardList[indexPath.row]
                cell.textLabel?.attributedText = self.createCardLabelText(card)
                cell.imageView?.sd_setImageWithURL(NSURL(string: card.url), placeholderImage: UIImage(named: "loadimage"))
            } else {
                // 存在しない場合はWEBから取得、登録して表示
                APIManager.getCardInfo(expantion, cardNumber: cardNumber, index:number, success: {(card: Card) in
                    // カード名セット
                    cell.textLabel?.attributedText = self.createCardLabelText(card)
                })
            }
        } else {
            let card = cardList[indexPath.row]
            cell.textLabel?.attributedText = self.createCardLabelText(card)
            cell.imageView?.sd_setImageWithURL(NSURL(string: card.url), placeholderImage: UIImage(named: "loadimage"))
        }
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if deck != nil {
            let oneAction = UITableViewRowAction(style: .Normal, title: "1", handler: { (action, indexPath) in
                self.addCard(indexPath, count: 1)
            })
            let twoAction = UITableViewRowAction(style: .Normal, title: "2", handler: { (action, indexPath) in
                self.addCard(indexPath, count: 2)
            })
            let threeAction = UITableViewRowAction(style: .Normal, title: "3", handler: { (action, indexPath) in
                self.addCard(indexPath, count: 3)
            })
            let fourAction = UITableViewRowAction(style: .Normal, title: "4", handler: { (action, indexPath) in
                self.addCard(indexPath, count: 4)
            })
            return [oneAction, twoAction, threeAction, fourAction]
        }
        return nil
    }
    
    // MARK: UITableViewDataSource
    // セル選択時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.deck != nil {
            let realm = try! Realm()
            // デッキ追加
            if msFlg {
                // MSデッキに追加
                try! realm.write{
                    deck.msDeck.append(cardList[indexPath.row])
                }
            } else {
                // クルーデッキに追加
                try! realm.write{
                    deck.crewDeck.append(cardList[indexPath.row])
                }
            }
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            // カードリスト
            // CardDetailViewControllerの生成
            let storyboard = UIStoryboard(name: CardDetailViewControllerStoryboardName, bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier(CardDetailViewControllerIdentifier) as! CardDetailViewController
            // パラメータセット
            viewController.cardList = cardList
            viewController.selectedIndex = indexPath.row
            
            // 遷移
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    // MARK: self methods
    func showFilterView(sender:UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "FilterViewController", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        viewController.modalPresentationStyle = .Popover
        viewController.preferredContentSize = CGSizeMake(400.0, 200.0)
        let weakSelf = self
        viewController.searchAction = {(blueSelected: Bool, greenSelected: Bool, blackSelected: Bool, yellowSelected: Bool, redSelected: Bool, pilotSelected: Bool, text: String) -> () in
            // filter条件の生成
            var fileterStr = ""
            let colors: NSMutableArray = []
            if blueSelected {
                colors.addObject("color = '青'")
            }
            if greenSelected {
                colors.addObject("color = '緑'")
            }
            if blackSelected {
                colors.addObject("color = '黒'")
            }
            if yellowSelected {
                colors.addObject("color = '黄'")
            }
            if redSelected {
                colors.addObject("color = '赤'")
            }
            if pilotSelected {
                colors.addObject("color = '無'")
            }
            
            if 0 < colors.count {
                fileterStr += "(" + colors.componentsJoinedByString(" OR ") + ") "
            }
            
            if 0 < text.characters.count {
                fileterStr += "AND (ability_1 CONTAINS '\(text)' OR ability_2 CONTAINS '\(text)')"
            }
            //            let predicate = NSPredicate(format: fileterStr, argumentArray: nil)
            if ((self.expantion) != nil) {
                weakSelf.cardList = weakSelf.expantion.cards.filter(fileterStr).sorted("card_number");
            } else {
                let realm = try! Realm()
                weakSelf.cardList = realm.objects(Card).filter(fileterStr).sorted("id")
            }
            self.filterFlg = true
            weakSelf.tableView.reloadData()
            
        }
        if let presentationController = viewController.popoverPresentationController {
            presentationController.permittedArrowDirections = .Unknown
            presentationController.delegate = self;
            presentationController.barButtonItem = sender
        }
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    /**
     コスト カード名を生成
     
     - parameter card: カード情報
     
     - returns: テキスト情報(NSMutableAttributedString)
     */
    func createCardLabelText(card: Card) -> NSMutableAttributedString {
        
        let cardText = NSMutableAttributedString()
        // コスト作成
        if (card.type != "4" && card.type != "5") {
            // 有色コスト
            if let color_restraint_2 = Int(card.color_restraint_2) {
                if 0 < color_restraint_2 {
                    let cardColor:UIColor = GCWUtils.getCardColor(card.color);
                    for _ in 0...color_restraint_2 {
                        let colorCost = NSMutableAttributedString(string: "●")
                        colorCost.addAttribute(NSForegroundColorAttributeName, value: cardColor, range: NSMakeRange(0, 1))
                        colorCost.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(30.0), range: NSMakeRange(0, 1))
                        cardText.appendAttributedString(colorCost)
                    }
                }
            }
            // 無色コスト
            if let cost = Int(card.cost) {
                let StringCount = GCWUtils.IntToStringCount(cost)
                if !StringCount.isEmpty {
                    let colorCost = NSMutableAttributedString(string: GCWUtils.IntToStringCount(cost))
                    colorCost.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(15.0), range: NSMakeRange(0, 1))
                    cardText.appendAttributedString(colorCost)
                }
            }
            cardText.appendAttributedString(NSMutableAttributedString(string:" "))
        }
        
        // カード名追加
        let cardName = NSMutableAttributedString(string: card.card_name)
        cardName.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12.0), range: NSMakeRange(0, cardName.length))
        cardText.appendAttributedString(cardName)
        
        // ユニットなら(ATK/DEF)付加
        if (card.type == "1") {
            let status = NSMutableAttributedString(string:"(\(card.atk)/\(card.def))")
            status.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12.0), range: NSMakeRange(0, status.length))
            cardText.appendAttributedString(status)
        }
        
        return cardText
    }
    
    func addCard(indexPath: NSIndexPath, count: Int) {
        let card = self.cardList[indexPath.row]
        
        let realm = try! Realm()
        for _ in 0..<count {
            if msFlg {
                try! realm.write({
                    self.deck.msDeck.append(card)
                })
            } else {
                try! realm.write({
                    self.deck.crewDeck.append(card)
                })
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

}
