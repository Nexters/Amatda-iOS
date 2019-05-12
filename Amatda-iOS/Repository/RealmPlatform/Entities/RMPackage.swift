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
