//
//  DomainConvertibleType.swift
//  Amatda-iOS
//
//  Created by JHH on 14/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}
