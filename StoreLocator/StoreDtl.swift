//
//  StoreDtl.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/27/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import Foundation


class StoreDtl {
    
    var storeNum: String?
    var street: String?
    var city: String?
    var brand: String?
    var managerFName: String?
    var managerLName: String?

    
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
}