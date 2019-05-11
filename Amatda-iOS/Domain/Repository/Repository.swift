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

protocol AbstractRepository {
    associatedtype T
    func queryAll() -> Observable<[T]>
    func saveCarrier(entity: T) -> Observable<Void>
    func saveCheckItem(entity: T) -> Observable<Void>
    func deleteCarrier(entity: T) -> Observable<Void>
    func deleteCheckItem(entity: T) -> Observable<Void>
}


final class Repository<T> : AbstractRepository where T : Object{
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler
    
    private var realm:Realm{
        return try! Realm(configuration: configuration)
    }
    
    
}
