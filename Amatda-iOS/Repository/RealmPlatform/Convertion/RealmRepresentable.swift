//
//  DomainConvertibleType.swift
//  Amatda-iOS
//
//  Created by JHH on 13/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType
    var uid: String{get}
    func asRealm() -> RealmType
}
