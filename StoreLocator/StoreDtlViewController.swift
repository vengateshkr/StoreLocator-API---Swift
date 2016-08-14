//
//  StoreDtlViewController.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/12/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import Foundation
class StoreDtlViewController : UIViewController
{
    var storeJson : JSON?
    var tableArray = [AnyObject]()
    var days = ["Monday","Tuesday","Wenesday","Thursday","Friday","Saturday","Sunday"]

    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
       super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.title = "Store Details"

        self.tableArray = populateData(storeJson!)
       self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {

    }
    
    
    func populateData(storeJSon:JSON?) -> [AnyObject]  {
        
        var arr = [AnyObject]()

        if storeJson!["store"] != nil {
            
            let storeDtl = StoreDtl()
            storeDtl.brand = storeDtl.getStoreBrand(storeJson!["store"]["storeBrand"].stringValue)
            storeDtl.storeNum = storeJson!["store"]["storeNum"].stringValue
            storeDtl.street = storeJson!["store"]["street"].stringValue
            storeDtl.city = storeJson!["store"]["city"].stringValue
            storeDtl.managerFName = storeJson!["store"]["managerFName"].stringValue
            storeDtl.managerLName = storeJson!["store"]["managerLName"].stringValue
            arr.append(storeDtl)

            let storeDtlCont = StoreContactDtl()
            storeDtlCont.storePhoneNum = storeJson!["store"]["storePhoneNum"].stringValue
            storeDtlCont.latitude = storeJson!["store"]["latitude"].stringValue
            storeDtlCont.latitude = storeJson!["store"]["longitude"].stringValue
            arr.append(storeDtlCont)

        }
        if storeJson!["storeHr"] != nil {
            
            let storeHr = StoreHours()
            storeHr.monOpen = storeJson!["storeHr"]["monOpen"].stringValue
            storeHr.monClose = storeJson!["storeHr"]["monOpen"].stringValue
            storeHr.tueOpen = storeJson!["storeHr"]["tueOpen"].stringValue
            storeHr.tueClose = storeJson!["storeHr"]["tueClose"].stringValue
            storeHr.wedOpen = storeJson!["storeHr"]["wedOpen"].stringValue
            storeHr.wedClose = storeJson!["storeHr"]["wedClose"].stringValue
            storeHr.thuOpen = storeJson!["storeHr"]["thuOpen"].stringValue
            storeHr.thuClose = storeJson!["storeHr"]["thuClose"].stringValue
            storeHr.friOpen = storeJson!["storeHr"]["friOpen"].stringValue
            storeHr.friClose = storeJson!["storeHr"]["friClose"].stringValue
            storeHr.satOpen = storeJson!["storeHr"]["satOpen"].stringValue
            storeHr.satClose = storeJson!["storeHr"]["satClose"].stringValue
            storeHr.sunOpen = storeJson!["storeHr"]["sunOpen"].stringValue
            storeHr.sunClose = storeJson!["storeHr"]["sunClose"].stringValue
            arr.append(storeHr)
            
        }
        if storeJson!["rxHr"] != nil {
            let rxHr = PharamacyHours()
            rxHr.monOpen = storeJson!["rxHr"]["monOpen"].stringValue
            rxHr.monClose = storeJson!["rxHr"]["monOpen"].stringValue
            rxHr.tueOpen = storeJson!["rxHr"]["tueOpen"].stringValue
            rxHr.tueClose = storeJson!["rxHr"]["tueClose"].stringValue
            rxHr.wedOpen = storeJson!["rxHr"]["wedOpen"].stringValue
            rxHr.wedClose = storeJson!["rxHr"]["wedClose"].stringValue
            rxHr.thuOpen = storeJson!["rxHr"]["thuOpen"].stringValue
            rxHr.thuClose = storeJson!["rxHr"]["thuClose"].stringValue
            rxHr.friOpen = storeJson!["rxHr"]["friOpen"].stringValue
            rxHr.friClose = storeJson!["rxHr"]["friClose"].stringValue
            rxHr.satOpen = storeJson!["rxHr"]["satOpen"].stringValue
            rxHr.satClose = storeJson!["rxHr"]["satClose"].stringValue
            rxHr.sunOpen = storeJson!["rxHr"]["sunOpen"].stringValue
            rxHr.sunClose = storeJson!["rxHr"]["sunClose"].stringValue
            arr.append(rxHr)
        }
        if storeJson!["clinicHr"] != nil {
            let clinicHr = ClinicHours()
            clinicHr.monOpen = storeJson!["clinicHr"]["monOpen"].stringValue
            clinicHr.monClose = storeJson!["clinicHr"]["monOpen"].stringValue
            clinicHr.tueOpen = storeJson!["clinicHr"]["tueOpen"].stringValue
            clinicHr.tueClose = storeJson!["clinicHr"]["tueClose"].stringValue
            clinicHr.wedOpen = storeJson!["clinicHr"]["wedOpen"].stringValue
            clinicHr.wedClose = storeJson!["clinicHr"]["wedClose"].stringValue
            clinicHr.thuOpen = storeJson!["clinicHr"]["thuOpen"].stringValue
            clinicHr.thuClose = storeJson!["clinicHr"]["thuClose"].stringValue
            clinicHr.friOpen = storeJson!["clinicHr"]["friOpen"].stringValue
            clinicHr.friClose = storeJson!["clinicHr"]["friClose"].stringValue
            clinicHr.satOpen = storeJson!["clinicHr"]["satOpen"].stringValue
            clinicHr.satClose = storeJson!["clinicHr"]["satClose"].stringValue
            clinicHr.sunOpen = storeJson!["clinicHr"]["sunOpen"].stringValue
            clinicHr.sunClose = storeJson!["clinicHr"]["sunClose"].stringValue
            arr.append(clinicHr)
        }

        return arr
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowCount = 1
        
        if self.tableArray.count > 0 {
            if section == 0 {
                rowCount = 1
            }
            if section == 1 {
                rowCount = 1
            }
            if section == 2 {
                rowCount = 7
            }
            if section == 3 {
                rowCount = 7
            }
            if section == 4 {
                rowCount = 7
            }
        }
        return rowCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell = UITableViewCell()
        var storeHr: StoreHours
        var pharmacyHr: PharamacyHours
        var clinicHr: ClinicHours
        
        if (indexPath.section == 0)
        {
            var cell = StoreDetailsCell()
            cell = self.tableView.dequeueReusableCellWithIdentifier("DetailsCell", forIndexPath: indexPath) as! StoreDetailsCell
            
            let store =  self.tableArray[indexPath.row] as! StoreDtl
            cell.userInteractionEnabled = true
            cell.storeAddress.text = store.storeNum
            cell.storeCityStateZip.text = String(format:"%@-%@",store.street!,store.city!)
            cell.StoreType.text = store.brand
            cell.storeDistance.text = String(format:"%@ %@",store.managerFName!,store.managerLName!)

            return cell
        }
        if (indexPath.section == 1)
        {
            var cell = StoreContactCell()
            cell = self.tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! StoreContactCell
            return cell
        }
        if (indexPath.section == 2)
        {
            var cell =  StoreHoursCell()
            cell = self.tableView.dequeueReusableCellWithIdentifier("storehourcell", forIndexPath: indexPath) as! StoreHoursCell
            cell.day.text = days[indexPath.row]
            
            if(self.tableArray[indexPath.section].description == "StoreLocator.StoreHours" )
            {
                storeHr = self.tableArray[indexPath.section] as! StoreHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.monOpen!,storeHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.tueOpen!,storeHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.wedOpen!,storeHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.thuOpen!,storeHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.friOpen!,storeHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.satOpen!,storeHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.sunOpen!,storeHr.sunClose!)
                }
            }
            if(self.tableArray[indexPath.section].description == "StoreLocator.PharamacyHours" )
            {
                pharmacyHr = self.tableArray[indexPath.section] as! PharamacyHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.monOpen!,pharmacyHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.tueOpen!,pharmacyHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.wedOpen!,pharmacyHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.thuOpen!,pharmacyHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.friOpen!,pharmacyHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.satOpen!,pharmacyHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.sunOpen!,pharmacyHr.sunClose!)
                }
            }
            if(self.tableArray[indexPath.section].description == "StoreLocator.ClinicHours" )
            {
                  clinicHr = self.tableArray[indexPath.section] as! ClinicHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.monOpen!,clinicHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.tueOpen!,clinicHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.wedOpen!,clinicHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.thuOpen!,clinicHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.friOpen!,clinicHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.satOpen!,clinicHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.sunOpen!,clinicHr.sunClose!)
                }
            }
            return cell
        }
        if (indexPath.section == 3)
        {
            var cell =  PharmacyHourCell()
            cell = self.tableView.dequeueReusableCellWithIdentifier("pharmacyhourcell", forIndexPath: indexPath) as! PharmacyHourCell
            cell.day.text = days[indexPath.row]
            
            if(self.tableArray[indexPath.section].description == "StoreLocator.StoreHours" )
            {
                storeHr = self.tableArray[indexPath.section] as! StoreHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.monOpen!,storeHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.tueOpen!,storeHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.wedOpen!,storeHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.thuOpen!,storeHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.friOpen!,storeHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.satOpen!,storeHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.sunOpen!,storeHr.sunClose!)
                }
            }
            if(self.tableArray[indexPath.section].description == "StoreLocator.PharamacyHours" )
            {
                pharmacyHr = self.tableArray[indexPath.section] as! PharamacyHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.monOpen!,pharmacyHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.tueOpen!,pharmacyHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.wedOpen!,pharmacyHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.thuOpen!,pharmacyHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.friOpen!,pharmacyHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.satOpen!,pharmacyHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.sunOpen!,pharmacyHr.sunClose!)
                }
            }
            if(self.tableArray[indexPath.section].description == "StoreLocator.ClinicHours" )
            {
                clinicHr = self.tableArray[indexPath.section] as! ClinicHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.monOpen!,clinicHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.tueOpen!,clinicHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.wedOpen!,clinicHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.thuOpen!,clinicHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.friOpen!,clinicHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.satOpen!,clinicHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.sunOpen!,clinicHr.sunClose!)
                }
            }
            return cell

        }
        if (indexPath.section == 4)
        {
            var cell =  ClinicHourCell()
            cell = self.tableView.dequeueReusableCellWithIdentifier("clinichourcell", forIndexPath: indexPath) as! ClinicHourCell
            cell.day.text = days[indexPath.row]
            if(self.tableArray[indexPath.section].description == "StoreLocator.StoreHours" )
            {
                storeHr = self.tableArray[indexPath.section] as! StoreHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.monOpen!,storeHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.tueOpen!,storeHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.wedOpen!,storeHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.thuOpen!,storeHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.friOpen!,storeHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.satOpen!,storeHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",storeHr.sunOpen!,storeHr.sunClose!)
                }
            }
            if(self.tableArray[indexPath.section].description == "StoreLocator.PharamacyHours" )
            {
                pharmacyHr = self.tableArray[indexPath.section] as! PharamacyHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.monOpen!,pharmacyHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.tueOpen!,pharmacyHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.wedOpen!,pharmacyHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.thuOpen!,pharmacyHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.friOpen!,pharmacyHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.satOpen!,pharmacyHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",pharmacyHr.sunOpen!,pharmacyHr.sunClose!)
                }
            }
            if(self.tableArray[indexPath.section].description == "StoreLocator.ClinicHours" )
            {
                clinicHr = self.tableArray[indexPath.section] as! ClinicHours
                if indexPath.row == 0 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.monOpen!,clinicHr.monClose!)
                }
                if indexPath.row == 1 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.tueOpen!,clinicHr.tueClose!)
                }
                if indexPath.row == 2 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.wedOpen!,clinicHr.wedClose!)
                }
                if indexPath.row == 3 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.thuOpen!,clinicHr.thuClose!)
                }
                if indexPath.row == 4 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.friOpen!,clinicHr.friClose!)
                }
                if indexPath.row == 5 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.satOpen!,clinicHr.satClose!)
                }
                if indexPath.row == 6 {
                    cell.StoreTime.text = String(format: "%@ - %@",clinicHr.sunOpen!,clinicHr.sunClose!)
                }
            }
            return cell
        }

        return tableCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        var secCount = 1
        
        if self.tableArray.count > 0 {
            secCount = self.tableArray.count
        }
        
        return secCount
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
     {
        var secHeader:String = ""
        
        if section == 0 {
            secHeader = "Store Details"
        }
        if section == 1 {
            secHeader = "Store Contacts"
        }
        if section == 2 {
            secHeader = self.tableArray[section].description
        }
        if section == 3 {
            secHeader = self.tableArray[section].description
        }
        if section == 4 {
            secHeader = self.tableArray[section].description
        }
        
        return secHeader
     }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var height : CGFloat = 0.0
        
        if indexPath.section == 0 {
            
            height = 123.0
        }
        if indexPath.section == 1 {
            
            height = 101.0
        }
        if indexPath.section == 2 {
            
            height = 44.0
        }
        if indexPath.section == 3 {
            
            height = 44.0
        }
        if indexPath.section == 4 {
            
            height = 44.0
        }
        return height
    }
    
    
    @IBAction func phoneClicked(sender: AnyObject) {

        let url : String = storeJson!["store"]["storePhoneNum"].stringValue
       makeCall(url)
    }
    
    @IBAction func mapClicked(sender: AnyObject) {
        
      let lat =  storeJson!["store"]["latitude"].stringValue
      let lng = storeJson!["store"]["longitude"].stringValue
       var urlStr = String(format: "http://maps.apple.com/?ll=%@,%@&t=s",lat,lng)
        urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!


    UIApplication.sharedApplication().openURL(NSURL(string:urlStr)!)
 
        
        
    }
    
    func makeCall(phone: String) {
        let formatedNumber = phone.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        let phoneUrl = "tel://\(formatedNumber)"
        let url:NSURL = NSURL(string: phoneUrl)!
        UIApplication.sharedApplication().openURL(url)
    }

    
    
}