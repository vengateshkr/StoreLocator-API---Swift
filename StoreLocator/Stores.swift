//
//  Stores.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/10/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import Foundation


class Stores {

    var stNum: String?
    var stadd: String?
    var sttyp: String?
    var stct: String?
    var stst: String?
    var stzp: String?
    var stdist: String?
    var stlat: String?
    var stlng: String?
    var sttmz: String?
    var storeType: String?
    var stposterInd: String?
    var stcreativeInd: String?
    var storeOpenTime: String?
    var storeCloseTime: String?
    var holidayEvent: String?
    var clinicOpenTime: String?
    var extendedHours: String?
    var clinicTypeInd: String?
    var locationName: String?
    var photoInd: String?
    var partnerName: String?
    var pharmacyExtendedHours: String?
    var nativeScheduler: String?
    var schedulingUrl: String?
    var telePharmacyKiosk: String?
    
    
    func getStoreBrand(brand:String) -> String
    {
        var b = "Walgreens"
        switch(brand)
        {
        case "WAG":
            b = "Walgreens"
            break
        case "DR":
            b = "Duane Reade"
        case "BOOTS":
            b = "Boots"
            break
        default:
            b = "Walgreens"
            break
        }
        return b
    }
    
    init () {

    }
    
}

