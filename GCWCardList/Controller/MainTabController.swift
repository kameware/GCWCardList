//
//  MainTabController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/04/29.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        var viewControllers: [UIViewController] = []

        // パック情報取得
        APIManager.getExpantionList()

        // カード情報メニュー
        let expantionMenuStoryboard: UIStoryboard =
            UIStoryboard(name: "ExpantionMenuViewController", bundle: nil)
        let expantionMenuViewController =
            expantionMenuStoryboard.instantiateViewControllerWithIdentifier("ExpantionMenuViewController")
        let expantionNavigationViewController: UINavigationController =
            UINavigationController(rootViewController: expantionMenuViewController)
        expantionNavigationViewController.tabBarItem =
            UITabBarItem(tabBarSystemItem: UITabBarSystemItem.MostRecent, tag: 1)
        viewControllers.append(expantionNavigationViewController)

        // デッキ情報
        let deckMenuStoryboard: UIStoryboard = UIStoryboard(name: "DeckMenuViewController", bundle: nil)
        let deckMenuViewController =
            deckMenuStoryboard.instantiateViewControllerWithIdentifier("DeckMenuViewController")
        let deckNavigationViewController: UINavigationController = UINavigationController(rootViewController: deckMenuViewController)
        deckNavigationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 2)
        viewControllers.append(deckNavigationViewController)

        self.setViewControllers(viewControllers, animated: false)

        self.selectedIndex = 0

    }

}
