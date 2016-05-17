//
//  DeckViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/18.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import SDWebImage

class DeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var deck:Deck!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = deck.name
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        // RefreshControl
        self.refreshControl.addTarget(self, action: #selector(DeckViewController.refreshControlEvent), forControlEvents: .ValueChanged)
        self.tableView.alwaysBounceVertical = true
        [self.tableView .addSubview(refreshControl)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 20.0))
        headerView.backgroundColor = UIColor.darkGrayColor()
        let sectionLabel = UILabel(frame: headerView.frame)
        if section == 1 {
            // デッキ
            sectionLabel.text = "デッキ"
        } else {
            // クルーデッキ
            sectionLabel.text = "クルーデッキ"
        }
        headerView .addSubview(sectionLabel)
        return headerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deck.cards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCardCell", forIndexPath: indexPath)
        
        let card = self.deck.cards[indexPath.row]
        
        // カード情報を設定
        cell.textLabel?.text = card.card_name
        cell.imageView?.sd_setImageWithURL(NSURL(string: card.url))
        
        return cell
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: RefreshControl method
    func refreshControlEvent(sender: AnyObject) {
        self.refreshControl.endRefreshing()
    }

}
