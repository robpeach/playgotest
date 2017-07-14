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
    @IBOutlet weak var todayBtn  :UIButton!
    @IBOutlet weak var tomorrowBtn : UIButton!
    @IBOutlet weak var satBtn : UIButton!
    @IBOutlet weak var sunBtn : UIButton!
    @IBOutlet weak  var satBtnWidth : NSLayoutConstraint!
    var sortedbyDistance : Bool!
    var feedItems: NSArray = NSArray()
    var filteredFeedItems: NSArray = NSArray()
    var currentLocation : CLLocation!
    var filteredType : FilterType!
    
    var locationManager: CLLocationManager!
    
    var selectedLocation : LocationModel = LocationModel()
    private let refreshControl = UIRefreshControl()
    enum FilterType : Int{
        case nothing
        case today
        case tomorrow
        case saturday
        case sunday
        
    }
    func ConfigButtonUI(btn : UIButton)
    {
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 0
        btn.layer.borderColor = UIColor.clear.cgColor
    }
    
    func getDayOfWeek()->Int {
        
        let todayDate = Date()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    func  getWeekend( day: Int) -> Date{
        
        let today = Date()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let todayWeekday = getDayOfWeek()
        
        let addWeekdays = 7 - todayWeekday + day
        var components = DateComponents()
        components.weekday = addWeekdays
        
        let nextweekend = calendar.date(byAdding: components, to: today, options: .matchFirst)
        return nextweekend!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredType = FilterType.nothing
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
        
        ConfigButtonUI(btn: azButton);
        ConfigButtonUI(btn: distanceButton);
        ConfigButtonUI(btn: todayBtn);
        ConfigButtonUI(btn: tomorrowBtn);
        ConfigButtonUI(btn: satBtn);
        ConfigButtonUI(btn: sunBtn);
        
        let today = getDayOfWeek();
        
        if(today == 5)
        {
            satBtnWidth.constant = 0;
            satBtn.isHidden  = true;
        }
        if(today == 6)
        {
            satBtnWidth.constant = 0;
            satBtn.isHidden = true;
            sunBtn.isHidden = true;
        }
        if(today == 1)
        {
            sunBtn.isHidden = true;
        }
        
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
        //
        feedItems =    feedItems.sorted(by: {ComapreDateAndDistance(obj1: $0 as! LocationModel,obj2: $1 as! LocationModel)
        }) as NSArray;
        self.listTableView.reloadData()
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
        
        if(segue.identifier == "show_filtteredfeed")
        {
            let filteredVC = segue.destination as! FilteredViewController
            filteredVC.filteredFeedItems = self.filteredFeedItems;
            filteredVC.currentLocation = self.currentLocation;
        }
        else{
            let detailVC  = segue.destination as! DetailViewController
            detailVC.selectedLocation = selectedLocation
        }
        
        
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
    func ComapreDateAndDistance(obj1 : LocationModel, obj2 :LocationModel) -> Bool
    {
        
        if(obj1.eventDate.compare(obj2.eventDate) == ComparisonResult.orderedSame)
        {
            return obj1.distance(to: currentLocation) < obj2.distance(to: currentLocation);
        }
        else{
            return obj1.eventDate.compare(obj2.eventDate) == ComparisonResult.orderedDescending ? false : true;
        }
        
    }
    
    func sortAndFilterData()
    {
        feedItems =    feedItems.sorted(by: {ComapreDateAndDistance(obj1: $0 as! LocationModel,obj2: $1 as! LocationModel)
        }) as NSArray;
        
        if(filteredType != FilterType.nothing)
        {
            var dateToFilter = "";
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            
            if(filteredType == FilterType.today)
            {
                let today  = Date()
                dateToFilter =  inputFormatter.string(from: today);
            }
            else if (filteredType == FilterType.tomorrow)
            {
                var dtTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                dateToFilter =  inputFormatter.string(from: dtTomorrow!);
            }
            else if (filteredType == FilterType.saturday)
            {
                dateToFilter =  inputFormatter.string(from: getWeekend(day: 0));
            }
            else if (filteredType == FilterType.sunday)
            {
                dateToFilter =  inputFormatter.string(from: getWeekend(day: 1));
            }
            
            
            let resultPredicate = NSPredicate(format: "date contains[c] %@", dateToFilter)
            filteredFeedItems  = feedItems.filtered(using: resultPredicate) as NSArray

            self.performSegue(withIdentifier: "show_filtteredfeed", sender: self)
        }
    }
    @IBAction func sortbySelectedField(_ sender: Any)
    {
        filteredType = FilterType(rawValue:  (sender as! UIButton).tag )
        sortAndFilterData()
        
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
