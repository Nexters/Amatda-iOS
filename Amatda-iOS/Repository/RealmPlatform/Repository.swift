//
//  Repository.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 11/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import Realm
import RealmSwift
import RxCocoa
import RxSwift
import RxRealm

protocol AbstractRepository {
    associatedtype T
    func queryAll() -> Observable<[T]>
    func save(entity: T) -> Observable<T>
    func delete(entity: T) -> Observable<Void>
}


final class Repository<T:RealmRepresentable> : AbstractRepository where T == T.RealmType.DomainType, T.RealmType: Object{
    private let configuration: Realm.Configuration
    private lazy var scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    private var realm:Realm{
        return try! Realm(configuration: configuration)
    }
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    func queryAll() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
                .subscribeOn(self.scheduler)
        }
    }
    
    func save(entity: T) -> Observable<T> {
        return Observable.deferred {
            return self.realm.rx.save(entity: entity)
            }.subscribeOn(self.scheduler)
    }
    
    func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
            }.subscribeOn(self.scheduler)
    }
}
