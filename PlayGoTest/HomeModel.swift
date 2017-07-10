//
//  HomeModel.swift
//  PlayGoTest
//
//  Created by Rob Mellor on 04/07/2017.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://britanniaclub.co.uk/pgdb.php" //this will be changed to the path where service.php lives

    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["name"] as? String,
                let address = jsonElement["address"] as? String,
                let latitude = jsonElement["latitude"] as? String,
                let longitude = jsonElement["longitude"] as? String,
                let image = jsonElement["image"] as? String,
                let event = jsonElement["event"] as? String,
                let eventimage = jsonElement["eventimage"] as? String,
                let date = jsonElement["date"] as? String
            {
                
                location.name = name
                location.address = address
                location.latitude = latitude
                location.longitude = longitude
                location.image = image
                location.event = event
                location.eventimage = eventimage
                location.date = date
                
                
            }
            
            locations.add(location)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: locations)
            
        })
    }
    
    
    
}
