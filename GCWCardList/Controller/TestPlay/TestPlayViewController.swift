//
//  TestPlayViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/14.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit
import DNDDragAndDrop

class TestPlayViewController: UIViewController, DNDDragSourceDelegate, DNDDropTargetDelegate {
    
    @IBOutlet var dragAndDropController: DNDDragAndDropController!
    
    @IBOutlet weak var unitFiledView1: UnitFieldView!
    @IBOutlet weak var unitFiledView2: UnitFieldView!
    @IBOutlet weak var unitFiledView3: UnitFieldView!
    @IBOutlet weak var unitFiledView4: UnitFieldView!
    @IBOutlet weak var unitFiledView5: UnitFieldView!
    @IBOutlet weak var unitFiledView6: UnitFieldView!
    @IBOutlet weak var unitFiledView7: UnitFieldView!
    
    @IBOutlet weak var deckView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.respondsToSelector(Selector("edgesForExtendedLayout")) {
            self.edgesForExtendedLayout = .None
        }
        
        self.dragAndDropController.registerDragSource(self.deckView, withDelegate: self)
        self.dragAndDropController.registerDropTarget(self.unitFiledView1, withDelegate: self.unitFiledView1)
        
//        self.dragAndDropController.registerDragSource(self.redView, withDelegate: self)
//        self.dragAndDropController.registerDropTarget(self.blueView, withDelegate: self)
//        self.dragAndDropController.registerDropTarget(self.greenView, withDelegate: self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: DNDDragSourceDelegate
    func draggingViewForDragOperation(operation: DNDDragOperation) -> UIView? {
        print("draggingViewForDragOperation")
        let dragView = CardView(frame: operation.draggingView.frame)
        dragView.alpha = 0.1
        dragView.userInteractionEnabled = true;
        dragView.clipsToBounds = true;
        dragView.backgroundColor = UIColor.lightGrayColor()
        UIView.animateWithDuration(0.2) {
            dragView.alpha = 1.0
        }
        return dragView
    }
    
    func dragOperationWillCancel(operation: DNDDragOperation) {
        print("dragOperationWillCancel")
        operation.removeDraggingViewAnimatedWithDuration(0.2) { (draggingView: UIView) in
            draggingView.alpha = 0.0
//            draggingView.center = operation.convertPoint(self.redView.center, fromView: self.view)
            print("x:\(self.view.frame.minX) y:\(self.view.frame.minY)")
        }
    }
    
    //MARK: DNDDropTargetDelegate
    func dragOperation(operation: DNDDragOperation, didDropInDropTarget target: UIView) {
        target.backgroundColor = operation.draggingView.backgroundColor
        target.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func dragOperation(operation: DNDDragOperation, didEnterDropTarget target: UIView) {
        target.layer.borderColor = operation.draggingView.backgroundColor?.CGColor
    }
    
    func dragOperation(operation: DNDDragOperation, didLeaveDropTarget target: UIView) {
        target.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
}
