//
//  Carrier.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 12/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct Carrier {
    let startDate   : String
    let carrierName : String
    let countryName : String
    let carrierID   : Int
    let packages    : [Package]
    
    init(startDate: String,
         carrierName: String = "캐리어",
         countryName: String,
         packages   : [Package] = [Package](),
         carrierID  : Int = Int(round(Date().timeIntervalSince1970 * 1000))
        ){
        self.startDate = startDate
        self.carrierName = carrierName
        self.countryName = countryName
        self.carrierID   = carrierID
        self.packages    = packages
    }
}
