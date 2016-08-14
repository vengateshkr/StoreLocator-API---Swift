//
//  ViewController.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/7/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import UIKit

class MapViewController: UIViewController,NSURLConnectionDelegate,UITableViewDelegate,CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate
{
    var mapTableViewCell = MapTableViewCell()
    let locationManager = CLLocationManager()
    var storesList: [Stores]?
    var storeJson: JSON?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store List"
        self.navigationController!.navigationBar.topItem!.title = "Back"
        let data = NSData()
        self.storeJson = JSON(data:data)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getLatLngForZip(zipCode: String) {
        let url = NSURL(string: "\(baseUrl)address=\(zipCode)&key=\(geoCodeApikey)")
        let data = NSData(contentsOfURL: url!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        if let result = json["results"] as? NSArray {
            if result.count > 0{
                if let geometry = result[0]["geometry"] as? NSDictionary {
                    if let location = geometry["location"] as? NSDictionary {
                        let latitude = location["lat"] as! Float
                        let longitude = location["lng"] as! Float
                      _ =  Post.sharedInstance.callStoreSearchApi(latitude,long: longitude,done:responseGetLocations)
                    }
                }
            }
            else
            {
            let alertController = UIAlertController(title: "Error", message: "Enter a correct zipcode", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                presentViewController(alertController, animated: true, completion: nil)
            
            }
        }
    }
    
    
    func responseGetLocations(data:NSData?,res:NSURLResponse?,error:NSError?)
    {
        self.storesList = []

        if (error != nil)
        {
            let alertController = UIAlertController(title: "API Error", message: error?.localizedDescription, preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
        else
        {
            if let data = data
            {
                let json = JSON(data: data)
                print("Get Locations Response:\n \(json)")
                let stores = json["stores"].arrayValue
                if stores.count > 0
                {
                    for i in 0 ..< stores.count
                    {
                        let store = Stores()
                        store.stNum = stores[i]["stnm"].stringValue
                        store.sttyp = stores[i]["sttyp"].stringValue
                        store.stadd = stores[i]["stadd"].stringValue
                        store.stct = stores[i]["stct"].stringValue
                        store.stst = stores[i]["stst"].stringValue
                        store.stzp = stores[i]["stzp"].stringValue
                        store.stdist = stores[i]["stdist"].stringValue
                        store.stlat = stores[i]["stlat"].stringValue
                        store.stlng = stores[i]["stlng"].stringValue
                        store.sttmz = stores[i]["sttmz"].stringValue
                        store.storeType = stores[i]["storeType"].stringValue
                        store.stposterInd = stores[i]["stposterInd"].stringValue
                        store.stcreativeInd = stores[i]["stcreativeInd"].stringValue
                        store.storeOpenTime = stores[i]["storeOpenTime"].stringValue
                        store.storeCloseTime = stores[i]["storeCloseTime"].stringValue

                        self.storesList?.append(store)
                    }
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                        self.annotateMap()
                    });
                    print("Locations Updated!")
                }
                else
                {
                    let alertController = UIAlertController(title: "Error", message: "No Stores Found!", preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                }
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message: "No Stores Found!", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }
    }

    func annotateMap()  {
        
        if  self.storesList?.count > 0 {
            
            for i in 0 ..< self.storesList!.count{
                let store = self.storesList![i] 
                let latDegree = Double(store.stlat!)
                let lngDegree = Double(store.stlng!)
                let camera = GMSCameraPosition.cameraWithLatitude(latDegree!,longitude:lngDegree!, zoom:10)
                let walgreensStore = GMSMarker()
                walgreensStore.position = CLLocationCoordinate2DMake(latDegree!, lngDegree!)
                walgreensStore.title = store.stadd!
                self.mapView.animateToLocation(walgreensStore.position)
                walgreensStore.map = mapView
                self.mapView.camera = camera
            }
            
        }

    }
    
     func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
     {

            let invalidCharacters = NSCharacterSet(charactersInString: "0123456789\n").invertedSet

            return text.rangeOfCharacterFromSet(invalidCharacters, options: [], range: text.startIndex ..< text.endIndex) == nil
    }
    

    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        if let zipCode = searchBar.text  {
            getLatLngForZip(zipCode)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.storesList?.count > 0) {
            return (self.storesList?.count)!
        }
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MapTableViewCell
      
        
        if (self.storesList?.count > 0) {
            let store =  self.storesList![indexPath.row]
            cell.userInteractionEnabled = true
            cell.StoreType.text = store.getStoreBrand(store.sttyp!)
            cell.storeAddress.text = store.stadd
            cell.storeCityStateZip.text = String(format:"%@-%@",store.stct!,store.stzp!)
            cell.storePhoneNumber.text  = "Pickup"
            cell.storeDistance.text = String(format:"%@ mi",store.stdist!)
        }
        else
        {
            cell.StoreType.text = "StoreType"
            cell.storeAddress.text = "StoreAddress"
            cell.storeCityStateZip.text = "StoreCity"
            cell.storePhoneNumber.text  = "Pickup"
            cell.storeDistance.text = "StoreDist"
            cell.userInteractionEnabled = false
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
       let store = self.storesList![indexPath.row]
        _ =  Post.sharedInstance.callStoreDetailsApi(store.stNum!, done:responseStrDetails)
        print(store)
    }
    
    
    func responseStrDetails(data:NSData?,res:NSURLResponse?,error:NSError?)
    {
        if (error != nil)
        {
            print("API error: \(error), \(error!.userInfo)")
        }
        else
        {
            if let data = data
            {
                self.storeJson = JSON(data: data)
                print("Get Details Response:\n \(self.storeJson)")
                dispatch_async(dispatch_get_main_queue(),{
                    self.performSegueWithIdentifier("toDetailsVC", sender: nil)
                });
            }
            else
            {
                print("No Stores Found!")
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toDetailsVC") {
            let storeDtlController = segue.destinationViewController as? StoreDtlViewController
            storeDtlController?.storeJson = self.storeJson!
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        locationManager.stopUpdatingLocation()
        let latitude  = Float(locValue.latitude)
        let longitude = Float(locValue.longitude)
         _ =  Post.sharedInstance.callStoreSearchApi(latitude,long: longitude,done:responseGetLocations)

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()
        let alertController = UIAlertController(title: "Error", message: "Kindly switch on your location services", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
}






