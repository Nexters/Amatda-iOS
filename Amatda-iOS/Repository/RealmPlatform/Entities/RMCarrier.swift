//
//  RMCarrier.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 12/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import RealmSwift
import Realm

final class RMCarrier: Object{
    @objc dynamic var startDate   : String = ""
    @objc dynamic var carrierName : String = ""
    @objc dynamic var countryName : String = ""
    @objc dynamic var carrierID   : Int = 0
    @objc dynamic var packages    : RMPackages = RMPackages()
    
    override static func primaryKey() -> String? {
        return "carrierID"
    }
}

extension RMCarrier: DomainConvertibleType {
    func asDomain() -> Carrier {
        return Carrier(startDate: startDate,
                       carrierName: carrierName,
                       countryName: countryName,
                       packages: packages.packages.mapToDomain(),
                       carrierID: carrierID
        )
    }
}

final class RMPackages: Object{
    var packages : List<RMPackage> = List<RMPackage>()
}


extension Carrier: RealmRepresentable{
    var uid: String {
        return "\(carrierID)"
    }
    
    func asRealm() -> RMCarrier {
        return RMCarrier.build({ object in
            object.carrierID    = self.carrierID
            object.startDate    = self.startDate
            object.countryName  = self.countryName
            object.carrierName  = self.carrierName
            
            for package in self.packages {
                object.packages.packages.append(package.asRealm())
            }
        })
    }
}
