//
//  Carrier.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 12/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

public struct Carrier {
    let startDate   : String
    let carrierName : String
    let countryName : String
    let carrierID   : String
    let packItem    : [Package]
    
    public init(startDate: String,
                carrierName: String = "캐리어",
                countryName: String,
                carrierID  : String = String(round(Date().timeIntervalSince1970 * 1000)),
                packItem   : [Package] = [Package]()
        ){
        self.startDate = startDate
        self.carrierName = carrierName
        self.countryName = countryName
        self.carrierID   = carrierID
        self.packItem    = packItem
    }
}
