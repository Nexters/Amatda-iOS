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
    //input
    let viewDidLoad = PublishSubject<Int>()
    
    //output
    var detailCarrier : Driver<Int>?
    
    let disposeBag = DisposeBag()
    init() {
        setup()
    }
    
    private func setup(){
        
        self.detailCarrier = viewDidLoad.flatMapLatest{
            APIClient.detailCarrier(carrierID: $0)
            }.asDriver(onErrorJustReturn: 0)
    }
}
