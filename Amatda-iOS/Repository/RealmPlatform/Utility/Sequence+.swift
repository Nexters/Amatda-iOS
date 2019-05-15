//
//  Sequence+.swift
//  Amatda-iOS
//
//  Created by JHH on 15/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation


extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            $0.asDomain()
        }
    }
}
