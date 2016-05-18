//
//  CardDetailViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/03.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import RealmSwift

let CardDetailViewControllerStoryboardName = "CardDetailViewController"
let CardDetailViewControllerIdentifier = "CardDetailViewController"

class CardDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var cardList:Results<Card>?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardCollectionView.delegate = self;
        self.cardCollectionView.dataSource = self;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.cardCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: self.selectedIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Right, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDelegate, Datasource
    // 行数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardList!.count
    }
    
    // セルの生成
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CardCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath) as! CardCollectionViewCell;
        cell.setCardInfo(cardList![indexPath.row], number:indexPath.row+1)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }

}
