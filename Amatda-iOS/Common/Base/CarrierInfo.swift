//
//  CarrierInfo.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 21/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct CarrierInfo {
    static var currentCarrierIndex: Int{
        set(newVal) {
            UserDefaults.standard.setValue(newVal, forKey: "carrierIndex")
        }
        
        get{
            if let index = UserDefaults.standard.object(forKey: "carrierIndex") as? Int {
                return index
            }
            return 0
        }
    }
}
