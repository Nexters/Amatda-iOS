//
//  MainUseCase.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 19/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import Realm
import RealmSwift
import RxSwift

protocol MainCase{
    func postAll() -> Observable<[Carrier]>
    func post(carrier:Carrier)    -> Observable<[Package]>
    func doCheck()
    func deletePackage()
}

final class MainUseCase<Repository>: MainCase where Repository: AbstractRepository, Repository.T == Carrier{
    private let repository: Repository
    
    init(repository:Repository) {
        self.repository = repository
    }
    
    func postAll() -> Observable<[Carrier]>{
        return self.repository.query(withSort: "created")
    }
    
    func post(carrier:Carrier) -> Observable<[Package]> {
        let carriers = self.repository.query(withFilter: "carrierID == \(carrier.carrierID)")
        return carriers.map{ $0.last!.packages }
    }
    
    func doCheck() {
        
    }
    
    func deletePackage() {
        
    }
}




