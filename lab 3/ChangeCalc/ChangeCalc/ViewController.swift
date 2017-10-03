//
//  ViewController.swift
//  ChangeCalc
//
//  Created by Alex Schwartz on 9/26/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var penniesAmount: UITextField!
    @IBOutlet weak var nickelsAmount: UITextField!
    @IBOutlet weak var dimesAmount: UITextField!
    @IBOutlet weak var quartersAmount: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var coinsImage: UIImageView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            penniesAmount.text = ""
            nickelsAmount.text = ""
            dimesAmount.text = ""
            quartersAmount.text = ""
            //create a UIAlertController object
            let alert=UIAlertController(title: "You're Broke", message: "The totals have been reset", preferredStyle: UIAlertControllerStyle.alert)
            //create a UIAlertAction object for the button
            let cancelAction=UIAlertAction(title: "Ok", style:UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction) //adds the alert action to the alert object
            let okAction=UIAlertAction(title: "Make me Rich", style: UIAlertActionStyle.default, handler: {action in
                self.penniesAmount.text = "1000"
                self.nickelsAmount.text = "1000"
                self.dimesAmount.text = "1100"
                self.quartersAmount.text = "1000"
                self.updateCoins()
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

    func updateCoins() {
        var pennies:Float
        var nickels:Float
        var dimes:Float
        var quarters:Float
        
        if penniesAmount.text!.isEmpty {
            pennies = 0.0
        } else {
            pennies = Float(penniesAmount.text!)!*0.01
        }
        
        if nickelsAmount.text!.isEmpty {
            nickels = 0.0
        } else {
            nickels = Float(nickelsAmount.text!)!*0.05
        }
        
        if dimesAmount.text!.isEmpty {
            dimes = 0.0
        } else {
            dimes = Float(dimesAmount.text!)!*0.1
        }
        
        if quartersAmount.text!.isEmpty {
            quarters = 0.0
        } else {
            quarters = Float(quartersAmount.text!)!*0.25
        }
        
        let total=pennies+nickels+dimes+quarters
        
        //format results as currency
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle=NumberFormatter.Style.currency //set the number style
        totalAmount.text=currencyFormatter.string(from: NSNumber(value: total)) //returns a formatted string
        
    

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateCoins()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.penniesAmount.inputAccessoryView = doneToolbar
        self.nickelsAmount.inputAccessoryView = doneToolbar
        self.dimesAmount.inputAccessoryView = doneToolbar
        self.quartersAmount.inputAccessoryView = doneToolbar

    }
    
    func doneButtonAction() {
        self.penniesAmount.resignFirstResponder()
        self.nickelsAmount.resignFirstResponder()
        self.dimesAmount.resignFirstResponder()
        self.quartersAmount.resignFirstResponder()

    }
    
    override func viewDidLoad() {
        penniesAmount.delegate=self
        nickelsAmount.delegate=self
        dimesAmount.delegate=self
        quartersAmount.delegate=self
        self.addDoneButtonOnKeyboard()
        coinsImage.image=UIImage(named: "us-coins")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

