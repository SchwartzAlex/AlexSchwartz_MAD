//
//  ViewController.swift
//  Seasons
//
//  Created by Alex Schwartz on 9/5/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var SeasonLabel: UILabel!
    @IBOutlet weak var SeasonImage: UIImageView!
    @IBAction func ChooseSeason(_ sender: UIButton) {
        if sender.tag == 1{
            SeasonImage.image=UIImage(named: "Spring")
            SeasonLabel.text="Spring"
            
        }
        if sender.tag == 2{
            SeasonImage.image=UIImage(named: "Summer")
            SeasonLabel.text="Summer"
        }
        if sender.tag == 3{
            SeasonImage.image=UIImage(named: "Fall")
            SeasonLabel.text="Fall"
        }
        if sender.tag == 4{
           SeasonImage.image=UIImage(named: "Winter")
            SeasonLabel.text="Winter"
        }
    }
    @IBOutlet weak var Fall: UIButton!
    @IBOutlet weak var Spring: UIButton!
    @IBOutlet weak var Summer: UIButton!
    @IBOutlet weak var Winter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Spring.layer.cornerRadius = 5
        Summer.layer.cornerRadius = 5
        Fall.layer.cornerRadius = 5
        Winter.layer.cornerRadius = 5
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

