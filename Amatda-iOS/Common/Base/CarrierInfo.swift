//
//  CarrierInfo.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 21/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct CarrierInfo {
    static func setCarrierID(carrierID : Int){
        var carriers = myCarrierID()
        carriers.append(carrierID)
        UserDefaults.standard.setValue(carriers, forKey: "myCarriersID")
        setCurrentCarrierID(index: carriers.count)
    }
    
    
    static func myCarrierID() -> [Int]{
        if let carrierID = UserDefaults.standard.object(forKey: "myCarriersID") as? [Int] {
            return carrierID
        }
        
        return []
    }
    
    
    
    static func setCurrentCarrierID(index : Int){
        let carriers = myCarrierID()
        UserDefaults.standard.setValue(carriers[index-1], forKey: "currentCarrier")
    }
    
    
    static func currentCarrierID()->Int{
        if let carrierID = UserDefaults.standard.object(forKey: "currentCarrier") as? Int {
            return carrierID
        }
        
        return 0
    }
}
