//
//  Scene2ViewContoller.swift
//  FitnessApp
//
//  Created by Alex Schwartz on 10/12/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit

class Scene2ViewContoller: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var machineText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var repsText: UITextField!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        machineText.delegate=self
        weightText.delegate=self
        repsText.delegate=self

        super.viewDidLoad()
        image.image=UIImage(named: "barbell")


        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { if segue.identifier == "doneWorkout"{
        let ViewController = segue.destination as! ViewController //check to see that text was entered in the textfields
        if machineText.text!.isEmpty == false{
            ViewController.user.machine=machineText.text }
        if weightText.text!.isEmpty == false{ ViewController.user.weight=weightText.text
        }
        if repsText.text!.isEmpty == false{ ViewController.user.reps=repsText.text
        }
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
