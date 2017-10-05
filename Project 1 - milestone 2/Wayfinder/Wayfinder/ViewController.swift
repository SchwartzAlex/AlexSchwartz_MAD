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
var heading = 0.0

func enableBasicLocationServices() {
    
}



class ViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buildingPicker: UIPickerView!
    @IBOutlet weak var compassArrow: UIImageView!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var currentLatLabel: UILabel!
    @IBOutlet weak var currentLongLabel: UILabel!
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var angleStatus: UIImageView!
    var builingIndicator = 0
    var latitude = 0.0
    var longitude = 0.0
    var radiansBearing = 0.0
    var d = 0.0
    let buildings:[(name: String, latitude: Double, longitude: Double)] = [("The North Pole", 90.0, 0.0), ("ATLAS Building", 40.007726, -105.269676), ("Norlin Library", 40.008653, -105.270860)]

    var locationManager: CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        buildingPicker.delegate=self
        buildingPicker.dataSource=self
        
        super.viewDidLoad()
        compassArrow.image=UIImage(named: "arrow")
        angleStatus.image=UIImage(named: "blueDot")
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy=kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.headingFilter = kCLHeadingFilterNone
            locationManager.startUpdatingHeading()
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return buildings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return buildings[row].name

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        buildingLabel.text = String(buildings[row].name)
        latLabel.text = String(buildings[row].latitude)
        longLabel.text = String(buildings[row].longitude)
        builingIndicator = row
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        bearingToLocationRadian()
        heading=newHeading.trueHeading
        angleStatus.transform = CGAffineTransform(rotationAngle: CGFloat(radiansBearing-(heading*3.14/180)))
    }
    
        func bearingToLocationRadian() {
            let lat1 = latitude*3.14/180
            let lon1 = longitude*3.14/180
            
            let lat2 = buildings[builingIndicator].latitude*3.14/180
            let lon2 = buildings[builingIndicator].longitude*3.14/180
            
            let dLon = lon2 - lon1
            let dLat = lat2 - lat1

            
            let y = sin(dLon) * cos(lat2)
            let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
            let R = 6371e3; // metres
            
            let a = sin(dLat/2) * sin(dLat/2) +
                cos(lat1) * cos(lat2) *
                sin(dLon/2) * sin(dLon/2);
            let c = 2 * atan2(sqrt(a), sqrt(1-a));
            
            d = R * c;
            radiansBearing = atan2(y, x)
                    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            if let location = locations.first{
                print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude) Elevation: \(location.altitude) Heading: \(heading)")
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
                currentLatLabel.text = String(format:"%.6f", location.coordinate.latitude)
                currentLongLabel.text = String(format:"%.6f", location.coordinate.longitude)
                elevationLabel.text = "\(Int(location.altitude*3.28084)) feet"
                distLabel.text = "\(Float(d)) meters"


                
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



