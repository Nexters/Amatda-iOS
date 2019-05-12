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
    @objc dynamic var packItem : [RMPackage] = []
}
