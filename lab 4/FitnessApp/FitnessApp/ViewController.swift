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
    @IBOutlet weak var image: UIImageView!
    let filename = "workouts.plist"
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        lastMachine.text=user.machine
        lastWeight.text=user.weight
        lastReps.text=user.reps


    }
    override func viewDidLoad() {
        image.image=UIImage(named: "barbell")

        let filePath = docFilePath(filename) //path to data file
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: filePath!){
            let path = filePath
            //load the data of the plist file into a dictionary
            let dataDictionary = NSDictionary(contentsOfFile: path!) as!
                [String:String]
            //load favorite book
            if dataDictionary.keys.contains("machine") { user.machine = dataDictionary["machine"]
                lastMachine.text=user.machine
            }
            //load favorite author
            if dataDictionary.keys.contains("weight") { user.weight = dataDictionary["weight"]
                lastWeight.text=user.weight
            } }
        
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
               super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
func docFilePath(_ filename: String) -> String?{
    //locate the documents directory
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
    let dir = path[0] as NSString //document directory //creates the full path to our data file
    return dir.appendingPathComponent(filename) }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

