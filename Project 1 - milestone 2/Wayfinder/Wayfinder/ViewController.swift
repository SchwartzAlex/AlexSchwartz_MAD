//
//  ViewController.swift
//  Wayfinder
//
//  Created by Alex Schwartz on 9/21/17.
//  Copyright © 2017 Alex Schwartz. All rights reserved.
//

import UIKit
import CoreLocation


var heading = 0.0

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
    var locationManager = CLLocationManager()

    var builingIndicator = 0
    var latitude = 0.0
    var longitude = 0.0
    var radiansBearing = 0.0
    var d = 0.0
    let buildings:[(name: String, latitude: Double, longitude: Double)] = [("The North Pole", 90.0, 0.0), ("ATLAS Building", 40.007726, -105.269676), ("Norlin Library", 40.008653, -105.270860), ("Engineering Center", 40.007073, -105.262997), ("Center For Community", 40.004532, -105.264986), ("University Memorial Center", 40.006850, -105.271806), ("Student Rec Center", 40.010115, -105.269403), ("Leeds School of Business", 40.005685, -105.263516), ("Folsom Field", 40.009443, -105.266895), ("Farrand Field", 40.006004, -105.267595), ("Norlin Quad", 40.008642, -105.272827), ("Hale Sciences", 40.009195, -105.275205), ("Macky Auditorium", 40.010039, -105.272695), ("Eaton Humanities", 40.009224, -105.271733), ("Eckley Sciences", 40.008132, -105.271763), ("Hellems Arts & Sciences", 40.007542, -105.272742), ("CHEM 140", 40.007377, -105.271238), ("Visual Arts Complex", 40.007500, -105.270547), ("Environmental Design", 40.006956, -105.269237), ("Imig Music Building", 40.006019, -105.269294), ("Flemming / Idea Forge", 40.001916, -105.263333), ("Wolf Law", 40.001419, -105.262167), ("Munzinger Auditorium", 40.008680, -105.269018), ("Duane Physics", 40.007990, -105.267143), ("Benson Earth Sciences", 40.007912, -105.265694), ("Math / Genmill Library", 40.007906, -105.264312), ("Coors Event Center", 40.004738, -105.260534), ("Fiske Planetarium", 40.003564, -105.263444), ("Sewall Hall", 40.010385, -105.271150), ("Baker Hall", 40.006770, -105.267828), ("Cheyenne Arapahoe Hall", 40.005265, -105.267841), ("Willard Hall", 40.005272, -105.266260), ("Farrand Hall", 40.006000, -105.265946), ("Willard Hall", 40.006817, -105.266366), ("Aden Hall", 40.006886, -105.265387), ("Brackett Hall", 40.007128, -105.265143), ("Cockerell Hall", 40.006691, -105.264535), ("Crosman Hall", 40.006217, -105.264782), ("Reed Hall", 40.005832, -105.264769), ("Hallett Hall", 40.005025, -105.264979), ("Kittredge West Hall", 40.002991, -105.264273), ("Kittredge Central Hall", 40.003165, -105.263326), ("Andrews Hall", 40.003250, -105.262171), ("Arnett Hall", 40.003339, -105.261108), ("Smith Hall", 40.002436, -105.261832), ("Buckingham Hall", 440.002376, -105.260813), ("Williams Village Campus", 39.998865, -105.250427)]

    override func viewDidLoad() {
        buildingPicker.delegate=self
        buildingPicker.dataSource=self
        
        super.viewDidLoad()
        compassArrow.image=UIImage(named: "arrow")
        angleStatus.image=UIImage(named: "dial")
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
                distLabel.text = "\(String(format:"%.2f", Float(d))) meters"


                
        }
    }
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status==CLAuthorizationStatus.authorizedWhenInUse {
                print("authorized")
                locationManager.startUpdatingLocation() //starts the location manager
            } else{
                if status==CLAuthorizationStatus.denied {
                    print("denied")
                }
            }
        }
        
        //called when a location cannot be determined
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("in didfailewitherror")
            print(error.localizedDescription)
            let code = (error as NSError).code
            print(code)
            var errorText = String()
            if !error.localizedDescription.isEmpty {
                switch code {
                case CLError.locationUnknown.rawValue:
                    errorText = "location unknown"
                case CLError.denied.rawValue:
                    errorText = "access denied"
                // add case statements for other values
                default:
                    errorText = "error"
                }
                let alertController = UIAlertController(title: "Location Access Disabled",
                                                        message: errorText,
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
        }

        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



