//
//  FilteredViewController.swift
//  PlayGoTest
//
//  Created by DARSHANA  on 27/07/17.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import CoreLocation

class FilteredViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var listTableView: UITableView!
    var selectedLocation : LocationModel = LocationModel()
    var filteredFeedItems: NSArray = NSArray()
    var currentLocation : CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "TableViewCell1")
        
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return filteredFeedItems.count
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let myCell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        // Get the location to be shown
        let item: LocationModel = filteredFeedItems[indexPath.row] as! LocationModel
        // Get references to labels of cell
        myCell.selectionStyle = .none
        myCell.eventLabel.text = item.event
        myCell.venueLabel.text = item.name
        
        let timeAsString = item.time
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let date = timeFormatter.date(from: timeAsString!)
        
        timeFormatter.dateFormat = "h:mm a"
        let date12 = timeFormatter.string(from: date!)
        
        myCell.timeLabel.text = date12
        if(currentLocation != nil)
        {
            let distance = item.distance(to: currentLocation);
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            let  strDistanceInMiles = formatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
            
            myCell.distanceLable.text = strDistanceInMiles + " miles" ;
        }
        let stringB = formattedDateFromString(dateString: (item.date)!, withFormat: "d MMM")
        
        myCell.dateLabel.text = stringB
        let imageURL:NSURL? = NSURL(string: (item.image)!)
        if let url = imageURL {
            myCell.venueImage.sd_setImage(with: url as URL)
        }
        let eventimageURL:NSURL? = NSURL(string: (item.eventimage)!)
        if let eventurl = eventimageURL {
            myCell.eventImage.sd_setImage(with: eventurl as URL)
        }
        
        
        
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedLocation = filteredFeedItems[indexPath.row] as! LocationModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! DetailViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedLocation = selectedLocation
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
