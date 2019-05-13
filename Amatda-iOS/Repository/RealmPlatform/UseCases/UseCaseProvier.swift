//
//  UseCaseProvier.swift
//  Amatda-iOS
//
//  Created by JHH on 13/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import Realm
import RealmSwift

public final class UseCaseProvider: UseCaseProvide{
    private let configuration : Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()){
        self.configuration = configuration
    }
    
    public func makeCarrierUseCase() -> CarrierUseCase {
        let repository = Repository<Carrier>(configuration: self.configuration)
        
    }
}
