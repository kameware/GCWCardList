//
//  DeckMenuViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/04/28.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import RealmSwift

/**
 * デッキ情報
 */
class DeckMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var deckList: Results<Deck>!
    var refreshControl: UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "デッキ管理"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // RefreshControl
        self.refreshControl.addTarget(self, action: #selector(DeckViewController.refreshControlEvent), forControlEvents: .ValueChanged)
        self.tableView.alwaysBounceVertical = true
        [self.tableView .addSubview(refreshControl)]
        
        // デッキ追加ボタン
        let deckAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DeckMenuViewController.addDeck))
        self.navigationItem.rightBarButtonItem = deckAddButton
        
        self.getDeckInfo()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MAKR: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deckList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckMenuCell", forIndexPath: indexPath)
        
        let deck = deckList[indexPath.row]
        
        // デッキ名設定
        cell.textLabel?.text = deck.name
        
        return cell
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // デッキ作成画面へ遷移
        let storyboard = UIStoryboard(name: "DeckViewController", bundle: nil)
        let deckViewController = storyboard.instantiateViewControllerWithIdentifier("DeckViewController") as! DeckViewController
        deckViewController.deck = self.deckList[indexPath.row]
        self.navigationController?.pushViewController(deckViewController, animated: true)
    }
    
    // MARK: self method
    func addDeck (sender: UIButton) {
        
        let weakSelf = self
        
        let alertController = UIAlertController(title: "デッキ名", message: "デッキ名を入力してください！", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (alert: UIAlertAction!) in
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alert: UIAlertAction!) in
            // デッキ名が入力されている場合だけ処理
            if let deckName = alertController.textFields![0].text {
                // デッキ名保存
                var deck: Deck!
                let realm = try! Realm()
                try! realm.write {
                    deck = realm.create(Deck.self, value: ["id" : weakSelf.deckList.count + 1, "name" : deckName], update: true)
                }
                
                // デッキ作成画面へ遷移
                let storyboard = UIStoryboard(name: "DeckViewController", bundle: nil)
                let deckViewController = storyboard.instantiateViewControllerWithIdentifier("DeckViewController") as! DeckViewController
                deckViewController.deck = deck
                
                weakSelf.navigationController?.pushViewController(deckViewController, animated: true)
            }
        }))
        
        // デッキ名入力フィールド
        alertController.addTextFieldWithConfigurationHandler { (text: UITextField!) in
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: RefreshControl method
    func refreshControlEvent(sender: AnyObject) {
        self.getDeckInfo()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: self methods
    func getDeckInfo () {
        // デッキ情報取得
        let realm = try! Realm()
        deckList = realm.objects(Deck).sorted("id")
        
    }


}
