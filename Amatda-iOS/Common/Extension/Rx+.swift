//
//  Observables+.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 21/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func suppressError() -> Observable<E> {
        return retryWhen { _ in return Observable<E>.empty()  }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
}


extension Reactive where Base: UIViewController{
    var viewDidload: ControlEvent<Void>{
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
    var viewWillAppear: ControlEvent<Void>{
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
        return ControlEvent(events: source)
    }
}
