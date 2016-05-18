//
//  DeckViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/18.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class DeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var deck:Deck!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = deck.name
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // RefreshControl
        self.refreshControl.addTarget(self, action: #selector(DeckViewController.refreshControlEvent), forControlEvents: .ValueChanged)
        self.tableView.alwaysBounceVertical = true
        [self.tableView .addSubview(refreshControl)]
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DeckSectionHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 40.0))
        var msFlg = true
        if section == 0 {
            // デッキ
            headerView.sectionLabel.text = "デッキ"
            msFlg = true
        } else {
            // クルーデッキ
            headerView.sectionLabel.text = "クルーデッキ"
            msFlg = false
        }
        
        // カード追加処理
        headerView.addCard = {
            let storyboard = UIStoryboard(name: CardListViewControllerStoryboardName, bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier(CardListViewControllerIdentifier) as! CardListViewController
            viewController.deck = self.deck
            viewController.msFlg = msFlg
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.deck.msDeck.count
        } else {
            return self.deck.crewDeck.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCardCell", forIndexPath: indexPath)
        
        var card: Card!
        if indexPath.section == 0 {
            card = self.deck.msDeck[indexPath.row]
        } else {
            card = self.deck.crewDeck[indexPath.row]
        }
        
        // カード情報を設定
        cell.textLabel?.text = card.card_name
        cell.imageView?.sd_setImageWithURL(NSURL(string: card.url))
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let realm = try! Realm()
            // カード情報削除
            if indexPath.section == 0 {
                try! realm.write {
                    self.deck.msDeck.removeAtIndex(indexPath.row)
                }
            } else {
                try! realm.write {
                    self.deck.crewDeck.removeAtIndex(indexPath.row)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: RefreshControl method
    func refreshControlEvent(sender: AnyObject) {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

}
