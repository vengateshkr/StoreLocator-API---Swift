//
//  MapTableViewCell.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/10/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import Foundation

class MapTableViewCell: UITableViewCell,CLLocationManagerDelegate {
    @IBOutlet weak var StoreType: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeCityStateZip: UILabel!
    @IBOutlet weak var storePhoneNumber: UILabel!
    @IBOutlet weak var storeDistance: UILabel!
    
}



