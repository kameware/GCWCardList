//
//  DeckMenuViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/04/28.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit

/**
 * デッキ情報
 */
class DeckMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "デッキ管理"
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
