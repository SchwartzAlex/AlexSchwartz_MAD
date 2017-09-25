//
//  ViewController.swift
//  Wayfinder
//
//  Created by Alex Schwartz on 9/21/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit
import CoreLocation


let locationManager = CLLocationManager()
func enableBasicLocationServices() {
    
}



class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var compassDial: UIImageView!
    @IBOutlet weak var angleStatus: UIImageView!
    
    var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        compassDial.image=UIImage(named: "compass")
        angleStatus.image=UIImage(named: "greenDot")

        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy=kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locDisabled() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "Loacation and compass access is required for wayfinding!",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            if let location = locations.first{
            print(location.coordinate)
        }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if (status == CLAuthorizationStatus.denied){
                locDisabled()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



