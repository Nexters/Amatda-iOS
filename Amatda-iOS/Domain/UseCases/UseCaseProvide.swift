//
//  UseCaseProvider.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 11/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public protocol UseCaseProvide {
    func makeCarrierUseCase() -> CarrierCase
}
