//
//  AMMainViewModel.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 30/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AMMainViewModel{
    let didTap = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    init() {
        setup()
    }
    
    private func setup(){
       didTap.asObserver().map{ _ in () }
    }
}
