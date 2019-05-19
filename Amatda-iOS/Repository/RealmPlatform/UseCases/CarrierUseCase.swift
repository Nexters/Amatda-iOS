//
//  CarrierUseCase.swift
//  Amatda-iOS
//
//  Created by JHH on 14/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

protocol CarrierCase{
    func post()    -> Observable<[Carrier]>
    func save(carrier: Carrier)    -> Observable<Carrier>
    func delete(carrier: Carrier)  -> Observable<Void>
}


final class CarrierUseCase<Repository>: CarrierCase where Repository: AbstractRepository, Repository.T == Carrier{
    private let repository: Repository
    
    init(repository:Repository) {
        self.repository = repository
    }
    
    func post() -> Observable<[Carrier]> {
        return repository.queryAll()
    }
    
    func save(carrier: Carrier) -> Observable<Carrier> {
        return repository.save(entity: carrier)
    }
    
    func delete(carrier: Carrier) -> Observable<Void> {
        return repository.delete(entity: carrier)
    }
}


