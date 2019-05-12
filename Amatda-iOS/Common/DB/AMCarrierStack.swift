//
//  AMCarrierStack.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 23/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RealmSwift


class CarrierRealm : Object{
    @objc dynamic var carrierID   : Int = 0
    @objc dynamic var startDate   : String = ""
    @objc dynamic var carrierName : String = ""
    @objc dynamic var carrierCountryID : Int = 0
}


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
        carrier.carrierName = element.carrierName
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(carrier)
        }
    }
    
    
    func carrierAt(index:Int)->Carrier?{
        for (i,carrier) in carriers.enumerated() {
            if i == index{
                return Carrier(startDate : carrier.startDate,
                               carrierName: carrier.carrierName,
                               countryName : cities[carrier.carrierCountryID]
                )
                
            }
        }
        
        return nil
    }
}
