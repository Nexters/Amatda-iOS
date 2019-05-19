//
//  Realm+Ext.swift
//  Amatda-iOS
//
//  Created by JHH on 13/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension Object{
    //builder  : Realm Object 생성하는 클로져
    //return O : Realm Object 생성해서 반환
    static func build<O: Object>(_ builder:(O)->() )->O{
        let object = O()
        builder(object)
        return object
    }
}

extension Reactive where Base:Realm{
    func save<R: RealmRepresentable>(entity: R, update: Bool = true)->Observable<R> where R.RealmType: Object{
        return Observable.create{ emit in
            do{
                try self.base.write {
                    self.base.add(entity.asRealm(), update: update)
                }
                emit.onNext(entity)
                emit.onCompleted()
            }catch{
                emit.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    
    func delete<R: RealmRepresentable>(entity:R)->Observable<Void> where R.RealmType: Object{
        return Observable.create{ emit in
            
            do{
                guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else { fatalError() }
                try self.base.write {
                    self.base.delete(object)
                }
                
                emit.onNext(())
                emit.onCompleted()
            }catch{
                emit.onError(error)
            }
            
            return Disposables.create()
        }
    }
}


