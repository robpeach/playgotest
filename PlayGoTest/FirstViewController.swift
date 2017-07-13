//
//  FirstViewController.swift
//  PlayGoTest
//
//  Created by Rob Mellor on 12/07/2017.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    var currentLocation : CLLocation!
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
//            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
//            
            
            
            //            let location1 = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            //            let location2 = CLLocation(latitude: CLLocationDegrees(selectedLocation.latitude!), longitude: CLLocationDegrees(selectedLocation.longitude!))
            //            let distance = location1.distance(from: location2)
            
            //            let sortDescriptor = NSSortDescriptor(key: "\(distance)", ascending: true)
            //            feedItems = feedItems.sortedArray(using: [sortDescriptor]) as NSArray
            
            
            
        }//if authorized
    }//locationManager func declaration
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = manager.location;
    
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
