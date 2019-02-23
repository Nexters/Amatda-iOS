//
//  AMCarrierStack.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 23/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RealmSwift

class AMCarrierStack {
    private lazy var carriers : Results<CarrierRealm> = {
        let realm = try! Realm()
        let carrs = realm.objects(CarrierRealm.self)

        return carrs
    }()
    
    var isEmpty: Bool{
        return self.carriers.isEmpty
    }
    
    
    var count : Int{
        return self.carriers.count
    }
 
    
    func push(_ element : Carrier){
        let carrier = CarrierRealm()
        carrier.startDate = element.startDate
        carrier.carrierCountryID = element.carrierCountryID
        carrier.carrierName = element.carrierName
        carrier.carrierID = element.carrierID
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(carrier)
        }
    }
    
    
    func carrierAt(index:Int)->Carrier?{
        for (i,carrier) in carriers.enumerated() {
            if i == index{
                return Carrier(carrierID : carrier.carrierID,
                               startDate : carrier.startDate,
                               carrierName: carrier.carrierName,
                               carrierCountryID : carrier.carrierCountryID)
                
            }
        }
        
        return nil
    }
}