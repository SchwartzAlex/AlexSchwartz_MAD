//
//  ViewController.swift
//  Midterm
//
//  Created by Alex Schwartz on 10/19/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var monthlySwitch: UISwitch!
    @IBOutlet weak var gallonsSlider: UISlider!

    @IBOutlet weak var milesText: UITextField!
    @IBOutlet weak var segmentMethod: UISegmentedControl!

    @IBOutlet weak var tankSlider: UISlider!
    @IBOutlet weak var gallonsLabel: UILabel!
    @IBOutlet weak var commuteLabel: UILabel!
    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var commuteImage: UIImageView!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    func updateCommute() {
        var commuteMiles:Float
        if milesText.text!.isEmpty {
            commuteMiles = 0.0
            
        } else {
            commuteMiles = Float(milesText.text!)!
        }
        gallonsLabel.text=String(format:"%.2f", tankSlider.value)
         if segmentMethod.selectedSegmentIndex == 0 {
            if monthlySwitch.isOn{

            let gasPurchase=(commuteMiles/24)*20
            let commuteTime=(commuteMiles*3)*20
            purchaseLabel.text=String(format:"%.2f", gasPurchase)
            commuteLabel.text=String(format:"%.2f", commuteTime)
            }
            else {
                let gasPurchase=commuteMiles/24
                let commuteTime=commuteMiles*3
                purchaseLabel.text=String(format:"%.2f", gasPurchase)
                commuteLabel.text=String(format:"%.2f", commuteTime)
            }


        }
         else if segmentMethod.selectedSegmentIndex == 1 {
            commuteImage.image=UIImage(named: "bus_icon")

            let gasPurchase=0.00
            purchaseLabel.text=String(format:"%.2f", gasPurchase)
            if monthlySwitch.isOn{

            let commuteTime=((commuteMiles*5)+10)*20
            commuteLabel.text=String(format:"%.2f", commuteTime)
            }
            else{
                
                let commuteTime=(commuteMiles*5)+10
                commuteLabel.text=String(format:"%.2f", commuteTime)
            }
        }
         else if segmentMethod.selectedSegmentIndex == 2 {
            commuteImage.image=UIImage(named: "bike_icon")
            let gasPurchase=0.00
            purchaseLabel.text=String(format:"%.2f", gasPurchase)
            if monthlySwitch.isOn{
            let commuteTime=commuteMiles*6*20
            commuteLabel.text=String(format:"%.2f", commuteTime)
            }
            else{
                let commuteTime=commuteMiles*6
                commuteLabel.text=String(format:"%.2f", commuteTime)
            }
        }
        if commuteMiles>50{
            //create a UIAlertController object
            let alert=UIAlertController(title: "Miles are over 50", message: "Pick a smaller commute", preferredStyle: UIAlertControllerStyle.alert)
            //create a UIAlertAction object for the button
            let cancelAction=UIAlertAction(title: "Ok", style:UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction) //adds the alert action to the alert object
            let okAction=UIAlertAction(title: "Reset", style: UIAlertActionStyle.default, handler: {action in
                self.milesText.text = "0"
                self.updateCommute()
            })
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }


        
        

    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Return", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.milesText.inputAccessoryView = doneToolbar
        
    }
    func doneButtonAction() {
        self.milesText.resignFirstResponder()
        updateCommute()

        
    }
    
    

    @IBAction func changeMonthly(_ sender: UISwitch) {
        updateCommute()
    }
    
    @IBAction func changeSlider(_ sender: UISlider) {
        updateCommute()

    }
    
    @IBAction func changeMethod(_ sender: UISegmentedControl) {
        updateCommute()

    }
    
    override func viewDidLoad() {
        milesText.delegate=self
        self.addDoneButtonOnKeyboard()
        commuteImage.image=UIImage(named: "car_icon")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

