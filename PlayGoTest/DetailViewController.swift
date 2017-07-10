//
//  DetailViewController.swift
//  PlayGoTest
//
//  Created by Rob Mellor on 04/07/2017.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class DetailViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    var selectedLocation : LocationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Create coordinates from location lat/long
        var poiCoodinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        poiCoodinates.latitude = CDouble(self.selectedLocation!.latitude!)!
        poiCoodinates.longitude = CDouble(self.selectedLocation!.longitude!)!
        // Zoom to region
        let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750)
        self.mapView.setRegion(viewRegion, animated: true)
        // Plot pin
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = poiCoodinates
        self.mapView.addAnnotation(pin)
        
        //add title to the pin
        pin.title = selectedLocation!.name
        
        
        //labels
        
        let stringB = formattedDateFromString(dateString: selectedLocation!.date!, withFormat: "d MMM")
        dateLabel.text = stringB
        
        venueLabel.text = selectedLocation!.name
        eventLabel.text = selectedLocation!.event
        let eventimageURL:NSURL? = NSURL(string: (selectedLocation?.eventimage)!)
        if let eventurl = eventimageURL {
            eventImage.sd_setImage(with: eventurl as URL)
        }
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
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
