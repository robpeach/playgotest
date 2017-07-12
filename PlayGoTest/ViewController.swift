//
//  ViewController.swift
//  PlayGoTest
//
//  Created by Rob Mellor on 04/07/2017.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//
import CoreLocation
import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, HomeModelProtocol, AlphaModelProtocol {
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var azButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var lblCurrentLOcation  :UILabel!
    var sortedbyDistance : Bool!
    var feedItems: NSArray = NSArray()
    var currentLocation : CLLocation!
    
    
    var locationManager: CLLocationManager!
    
    var selectedLocation : LocationModel = LocationModel()
    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sortedbyDistance = false;
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        lblCurrentLOcation.text = "myLocation: 0 , 0";
        listTableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "TableViewCell1")
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        //location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        azButton.backgroundColor = .orange
        azButton.layer.cornerRadius = 5
        azButton.layer.borderWidth = 0
        azButton.layer.borderColor = UIColor.clear.cgColor
        
        distanceButton.backgroundColor = .orange
        distanceButton.layer.cornerRadius = 5
        distanceButton.layer.borderWidth = 0
        distanceButton.layer.borderColor = UIColor.clear.cgColor
        
        
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        listTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData(sender:)), for: .valueChanged)
        
        
        
        
    }
    
    
    
    
    func refreshData(sender: UIRefreshControl) {
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        
        
        DispatchQueue.main.async{
            
            self.listTableView.reloadData()
        }
        
        refreshControl.endRefreshing()
    }
    
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        if(sortedbyDistance && currentLocation != nil)
        {
            feedItems =    feedItems.sorted(by: { ($0 as! LocationModel).distance(to: currentLocation) < ($1 as! LocationModel).distance(to: currentLocation) }) as NSArray;
        }
        //sort for distance
        
        //
        
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let myCell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        // Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
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
        
        let distance = item.distance(to: currentLocation);
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let  strDistanceInMiles = formatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
        
        myCell.distanceLable.text = strDistanceInMiles + " miles" ;
        
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
        
        
        print(indexPath.row);
        print(item.distance(to: currentLocation));
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedLocation = feedItems[indexPath.row] as! LocationModel
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
    
    
    @IBAction func azPress(_ sender: Any) {
        let alphaModel = AlphaModel()
        alphaModel.delegate = self
        alphaModel.downloadItems()
        sortedbyDistance  = false;
        DispatchQueue.main.async{
            
            self.listTableView.reloadData()
        }
    }
    
    @IBAction func sortByDistancePressed(_ sender: Any) {
        //        let alphaModel = AlphaModel()
        //        alphaModel.delegate = self
        //        alphaModel.downloadItems()
        if(currentLocation == nil)
        {
            let alert = UIAlertController.init(title: "", message: "Current location not available", preferredStyle:  UIAlertControllerStyle.alert);
            alert.show(self, sender: distanceButton);
            
        }
        sortedbyDistance  = true;
        
        // { delete following code at the end
        print ("distance before Sort");
        for item in feedItems{
            
            print((item as! LocationModel).distance(to: currentLocation));
        }
        ///}
        feedItems =    feedItems.sorted(by: { ($0 as! LocationModel).distance(to: currentLocation) < ($1 as! LocationModel).distance(to: currentLocation) }) as NSArray;
        print( "after sort");
        for item in feedItems{
            
            print((item as! LocationModel).distance(to: currentLocation));
        }
        DispatchQueue.main.async{
            
            self.listTableView.reloadData()
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
    
    //location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            
            
            
            //            let location1 = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            //            let location2 = CLLocation(latitude: CLLocationDegrees(selectedLocation.latitude!), longitude: CLLocationDegrees(selectedLocation.longitude!))
            //            let distance = location1.distance(from: location2)
            
            //            let sortDescriptor = NSSortDescriptor(key: "\(distance)", ascending: true)
            //            feedItems = feedItems.sortedArray(using: [sortDescriptor]) as NSArray
            
            
            
        }//if authorized
    }//locationManager func declaration
    
    
    @IBAction func todayPressed(_ sender: Any) {
        
        if(currentLocation == nil)
        {
            let alert = UIAlertController.init(title: "", message: "Current location not available", preferredStyle:  UIAlertControllerStyle.alert);
            alert.show(self, sender: distanceButton);
            
        }
        sortedbyDistance  = true;
        
        // { delete following code at the end
        print ("distance before Sort");
        for item in feedItems{
            
            print((item as! LocationModel).distance(to: currentLocation));
        }
        ///}
        feedItems =    feedItems.sorted(by: { ($0 as! LocationModel).distance(to: currentLocation) < ($1 as! LocationModel).distance(to: currentLocation) }) as NSArray;
        print( "after sort");
        for item in feedItems{
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            
            
            print((item as! LocationModel).distance(to: currentLocation));
        }
        
        //NEEDS TO SHOW EVENTS THAT ARE TODAY 

        
        DispatchQueue.main.async{
            
            self.listTableView.reloadData()
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = manager.location;
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 3
        formatter.maximumFractionDigits = 3
        
        let lat = formatter.string(from: NSNumber(value: currentLocation.coordinate.latitude));
        let lon = formatter.string(from: NSNumber(value: currentLocation.coordinate.longitude));
        lblCurrentLOcation.text = "myLocation: " + lat! + ", " + lon!;
    }
}
