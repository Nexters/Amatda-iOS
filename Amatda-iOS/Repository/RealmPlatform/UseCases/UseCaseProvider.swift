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

final class UseCaseProvider: UseCaseProvide{
    private let configuration : Realm.Configuration
    
    init(configuration: Realm.Configuration = Realm.Configuration()){
        self.configuration = configuration
    }
    
    func makeCarrierUseCase() -> CarrierCase {
        let repository = Repository<Carrier>(configuration: self.configuration)
        return CarrierUseCase(repository: repository)
    }
    
    func makeMainUseCase() -> MainCase {
        let repository = Repository<Carrier>(configuration: self.configuration)
        return MainUseCase(repository: repository)
    }
}
