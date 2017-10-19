//
//  ViewController.swift
//  FitnessApp
//
//  Created by Alex Schwartz on 10/12/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var user=workout()
    @IBOutlet weak var lastMachine: UILabel!
    @IBOutlet weak var lastWeight: UILabel!
    @IBOutlet weak var lastReps: UILabel!
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){ lastMachine.text=user.machine
        lastWeight.text=user.weight
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

