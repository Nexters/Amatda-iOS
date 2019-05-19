//
//  RMPackage.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 12/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import RealmSwift
import Realm

final class RMPackage: Object{
    @objc dynamic var packageID : Int = 0
    @objc dynamic var carrierID : Int = 0
    @objc dynamic var packageName : String = ""
    @objc dynamic var packageColor : String = ""
    @objc dynamic var check : Bool = false
}


extension RMPackage: DomainConvertibleType{
    func asDomain() -> Package{
        return Package(carrierID: carrierID,
                       packageID: packageID,
                       packageName: packageName,
                       packageColor: packageColor,
                       check: check)
    }
}


extension Package: RealmRepresentable{
    var uid: String {
        return "\(packageID)"
    }
    
    func asRealm() -> RMPackage {
        return RMPackage.build({ object in
            object.packageID    = self.packageID
            object.carrierID    = self.carrierID
            object.packageName  = self.packageName
            object.packageColor = self.packageColor
            object.check        = self.check
        })
    }
}
