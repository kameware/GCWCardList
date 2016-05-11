
//
//  FilterViewController.swift
//  GCWCardList
//
//  Created by mineharu on 2016/05/09.
//  Copyright © 2016年 Mineharu. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var pilotButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchAction: (blueSelected: Bool, greenSelected: Bool, blackSelected: Bool, yellowSelected: Bool, redSelected: Bool, pilotSelected: Bool, text: String) -> () = {
        (blueSelected: Bool, greenSelected: Bool, blackSelected: Bool, yellowSelected: Bool, redSelected: Bool, pilotSelected: Bool, text: String) -> () in
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchUpCloseButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func touchUpSearchButton(sender: AnyObject) {
        self.searchAction(blueSelected: self.blueButton.selected, greenSelected: self.greenButton.selected, blackSelected: self.blackButton.selected, yellowSelected: self.yellowButton.selected, redSelected: self.redButton.selected, pilotSelected: self.pilotButton.selected, text: self.searchTextField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func touchUpBlueButton(sender: AnyObject) {
        self.blueButton.selected = !self.blueButton.selected
    }
    
    @IBAction func touchUpGreenButton(sender: AnyObject) {
        self.greenButton.selected = !self.greenButton.selected
    }
    
    @IBAction func touchUpBlackButton(sender: AnyObject) {
        self.blackButton.selected = !self.blackButton.selected
    }
    
    @IBAction func touchUpYellowButton(sender: AnyObject) {
        self.yellowButton.selected = !self.yellowButton.selected
    }
    
    @IBAction func touchUpRedButton(sender: AnyObject) {
        self.redButton.selected = !self.redButton.selected
    }
    @IBAction func touchUpPilotbutton(sender: AnyObject) {
        self.pilotButton.selected = !self.pilotButton.selected
    }
}
