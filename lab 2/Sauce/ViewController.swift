//
//  ViewController.swift
//  Sauce
//
//  Created by Alex Schwartz on 9/14/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var realestLabel: UILabel!
    @IBOutlet weak var SauceImage: UIImageView!
    @IBOutlet weak var SauceText: UILabel!
    @IBOutlet weak var SauceSelection: UISegmentedControl!
    @IBOutlet weak var realestSwitch: UISwitch!
    @IBOutlet weak var gucciScore: UILabel!
    @IBOutlet weak var goldiScore: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var lostSlider: UISlider!
    var audioPlayer = AVAudioPlayer()
    private var gucciVar = 0
    private var goldiVar = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.loadGif(name: "dennis_nedry_magic_word_header")
        voteButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        gucciScore.text = "\(gucciVar)"
        goldiScore.text = "\(goldiVar)"
        // Do any additional setup after loading the view, typically from a nib.
    }
    func updateImage(){
        if realestSwitch.isOn{
            line2.text=line2.text?.uppercased()

            realestLabel.text = "Goldilocks"
        }
        else {
            realestLabel.text = "Gucci Mane"
            line2.text=line2.text?.lowercased()

        }
        if SauceSelection.selectedSegmentIndex == 0 {

        if realestSwitch.isOn{
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bornWithSauce", ofType: "mp3")!))
                audioPlayer.play()
            }
            catch{
                print(error)
            }
            
            SauceImage.image=UIImage(named: "goldilocksNoSauce")
        }
        else {
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "noSauce", ofType: "mp3")!))
                audioPlayer.play()
            }
            catch{
                print(error)
            }
            SauceImage.image=UIImage(named: "noSauce")
        }
        }
        else if SauceSelection.selectedSegmentIndex == 1{

            if realestSwitch.isOn{
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "overdose", ofType: "mp3")!))
                    audioPlayer.play()
                }
                catch{
                    print(error)
                }
                SauceImage.image=UIImage(named: "goldilocksSauce")
            }
            else {
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sauce", ofType: "mp3")!))
                    audioPlayer.play()
                }
                catch{
                    print(error)
                }
                SauceImage.image=UIImage(named: "sauce")
            }
            }
    }
     func updateImage2(){
        if realestSwitch.isOn{
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "goldi", ofType: "mp3")!))
                audioPlayer.play()
            }
            catch{
                print(error)
            }
            SauceImage.image=UIImage(named: "GoldiLocks")
            realestLabel.text = "Goldilocks"
            SauceSelection.selectedSegmentIndex = UISegmentedControlNoSegment

        }
        else {
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gucci", ofType: "mp3")!))
                audioPlayer.play()
            }
            catch{
                print(error)
            }
            SauceImage.image=UIImage(named: "GucciMane")
            realestLabel.text = "Gucci Mane"
            SauceSelection.selectedSegmentIndex = UISegmentedControlNoSegment

        }
    }
        func updateText(){
            line1.text = ""
            line2.font=UIFont.systemFont(ofSize: 18)
            line2.textAlignment=NSTextAlignment.center
            if (lostSlider.value<1 && lostSlider.value>0){
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "isItHard", ofType: "mp3")!))
                    audioPlayer.play()
                }
                catch{
                    print(error)
                }
                line2.text = "Not that Lost"
                
            }
            else if (lostSlider.value>1 && lostSlider.value<2){
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "noMoney", ofType: "mp3")!))
                    audioPlayer.play()
                }
                catch{
                    print(error)
                }
                line2.text = "Kinda Lost"
            }
            else if (lostSlider.value>2 && lostSlider.value<3){
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bitchGonGetLost", ofType: "mp3")!))
                    audioPlayer.play()
                }
                catch{
                    print(error)
                }
                line2.text = "Pretty Lost"
            }
            else if (lostSlider.value>3 && lostSlider.value<4){
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "acquire", ofType: "mp3")!))
                    audioPlayer.play()
                }
                catch{
                    print(error)
                }
                line2.text = "So Lost"
            }
            line3.text = ""
            if realestSwitch.isOn{
                line2.text=line2.text?.uppercased()
                line2.textColor = UIColor.red

                }
            else {
                line2.text=line2.text?.lowercased()
                line2.textColor = UIColor.green

            }

        }

    
    @IBAction func reset(_ sender: UIButton) {
        goldiVar=0
        gucciVar=0
        goldiScore.text = "\(goldiVar)"
        gucciScore.text = "\(gucciVar)"
        line2.textAlignment=NSTextAlignment.left
        line2.font=UIFont.systemFont(ofSize: 15)
        line1.text = "\"If you don't have the sauce, then you're lost."
        line2.text = "But you can also be lost in the sauce.\""
        line3.text = "- Gucci Mane"
        line2.textColor = UIColor.black

        SauceImage.image=UIImage(named: "GucciMane")
        realestLabel.text = "Gucci Mane"
        realestSwitch.isOn=false
        SauceSelection.selectedSegmentIndex = UISegmentedControlNoSegment
        
    }
    @IBAction func castVote(_ sender: UIButton) {
        if realestSwitch.isOn{
            goldiVar+=1
            goldiScore.text = "\(goldiVar)"

        }
        else {
            gucciVar+=1
            gucciScore.text = "\(gucciVar)"
        }
        if gucciVar==69{
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GetTheBag", ofType: "mp3")!))
                audioPlayer.play()
            }
            catch{
                print(error)
            }
        }
        if goldiVar==69{
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Goldie", ofType: "mp3")!))
                audioPlayer.play()
            }
            catch{
                print(error)
            }
        }
    }
    @IBAction func changeSlider(_ sender: UISlider) {
        updateText()
    }
    @IBAction func changeInfo(_ sender: UISegmentedControl) {
        updateImage()
    }

    @IBAction func changeRealest(_ sender: UISwitch) {
        updateImage2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
