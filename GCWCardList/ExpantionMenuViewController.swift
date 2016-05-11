//
//  ExpantionMenuViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/04/28.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import RealmSwift

/**
 * カード情報
 */
class ExpantionMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var expantions: Results<Expantion>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "カードリスト"

        self.tableView.dataSource = self
        self.tableView.delegate   = self
        
        let sortProperties = [
            SortDescriptor(property: "sort_number", ascending: true),
            SortDescriptor(property: "expantion_number", ascending: true)]
        
        self.expantions = realm.objects(Expantion)
                                .sorted(sortProperties)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // すべて＋パック数
        return self.expantions.count + 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ExpantionMenuCell", forIndexPath: indexPath)

        if (indexPath.row == 0) {
            cell.textLabel?.text = "すべて"
        } else {
            cell.textLabel?.text = self.expantions[indexPath.row - 1].expantion_name
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "CardListViewController", bundle: nil)
        let cardListViewController = storyboard.instantiateViewControllerWithIdentifier("CardListViewController") as! CardListViewController
        if (0 < indexPath.row) {
            cardListViewController.expantion = self.expantions[indexPath.row - 1]
        }
        
        self.navigationController?.pushViewController(cardListViewController, animated: true)
    }
}
