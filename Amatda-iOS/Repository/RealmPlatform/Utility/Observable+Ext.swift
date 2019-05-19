//
//  Observable+Ext.swift
//  Amatda-iOS
//
//  Created by JHH on 14/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RxSwift

extension Observable where Element: Sequence, Element.Iterator.Element: DomainConvertibleType {
    typealias DomainType = Element.Iterator.Element.DomainType
    
    func mapToDomain() -> Observable<[DomainType]> {
        return map {
            $0.mapToDomain()
        }
    }
}

