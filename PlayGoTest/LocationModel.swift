//
//  LocationModel.swift
//  PlayGoTest
//
//  Created by Rob Mellor on 04/07/2017.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//

import Foundation

import CoreLocation
class LocationModel: NSObject {
    
    //properties
    
    var name: String?
    var address: String?
    var latitude: String?
    var longitude: String?
    var image: String?
    var event: String?
    var eventimage: String?
    var date: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(name: String, address: String, latitude: String, longitude: String, image: String, event: String, eventimage: String, date: String) {
        
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.event = event
        self.eventimage = eventimage
        self.date = date
        
    }
     var location: CLLocation {
        
        return CLLocation(latitude: Double(self.latitude!)!, longitude: Double(self.longitude!)!);
    }

    
    func distance(to location: CLLocation) -> CLLocationDistance {
        let distanceinmeter = location.distance(from: self.location)
        let distanceinmiles = distanceinmeter / 1609.344;
        return distanceinmiles;
    }
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(String(describing: name)), Address: \(String(describing: address)), Latitude: \(String(describing: latitude)), Longitude: \(String(describing: longitude)), image: \(String(describing: image)), event: \(String(describing: event)), eventimage: \(String(describing: eventimage)), date: \(String(describing: date))"
        
    }
    
    
}
