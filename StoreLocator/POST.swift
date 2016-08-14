//
//  POST.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/7/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import Foundation

class Post:NSObject
{
    
    static let sharedInstance = Post()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    
    /* Passing Latitude , Longtude , Affiliate Id and ApiKey as dynamic parameters to the request*/
    
    func callStoreSearchApi(lat:Float,long:Float , done: (NSData?, NSURLResponse?, NSError?) -> ())
    {
        let searchOptStr = prepareSearchOptions(appDelegate.selectedOptionsArr)
        
        let storesReqStr = NSString(format:"{\r\n\"affId\":\"%@\",\r\n\"apiKey\":\"%@\",\r\n\"lat\":\"%f\",\r\n\"lng\":\"%f\",\r\n\"srchOpt\":\"%@\",\r\n\"nxtPrev\":\"\",\r\n\"requestType\":\"locator\",\r\n\"act\":\"fndStore\",\r\n\"view\":\"fndStoreJSON\",\r\n\"devinf\":\"iPhone,9.0\",\r\n\"appver\":\"1.0\"\r\n}",affiliateID,apiKey,lat,long,searchOptStr);
        
        let url = NSURL(string: "https://services-qa.walgreens.com/api/stores/search")
        let request = NSMutableURLRequest(URL:url!)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = storesReqStr.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: done )
        task.resume()
    }
    
    
    /* Passing store , Affiliate Id and ApiKey as parameters to the request*/

    
    func callStoreDetailsApi(storeNumber:String , done: (NSData?, NSURLResponse?, NSError?) -> ())
    {
        
        let storesDtlReqStr = NSString(format:"{\r\n\"affId\":\"%@\",\r\n\"apiKey\":\"%@\",\r\n\"storeNo\":\"%@\",\r\n\"act\":\"storeDtl\",\r\n\"view\":\"storeDtlJSON\",\r\n\"devinf\":\"iPhone,9.0\",\r\n\"appver\":\"1.0\"\r\n}",affiliateID,apiKey,storeNumber);
        
        let url = NSURL(string: "https://services-qa.walgreens.com/api/stores/details")
        let request = NSMutableURLRequest(URL:url!)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = storesDtlReqStr.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: done )
        task.resume()
    }
    
    func prepareSearchOptions(array:[String])-> String
    {
        var returnStr = ""
        if array.count > 0 {
            for i in 0 ..< array.count{
                returnStr = returnStr + String(format:"%@,", array[i])
            }
           returnStr = String(returnStr.characters.dropLast())
        }
        else
        {
            returnStr = ""
        }
        print(returnStr)
        return returnStr
    }

}