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
    let viewDidLoad         = PublishSubject<Int>()
    let completeCarrierInfo = PublishSubject<CarrierModel>()
    
    //output
    var detailCarrier : Driver<CarrierModel>?
    var packageList   : Driver<PackageModel>?
    let apiError = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    init() {
        setup()
    }
    
    /*
     .do(onError:{ error in
     self.registerError.onNext("")
     }).suppressError()
     */
    private func setup(){
        self.detailCarrier = viewDidLoad
            .flatMapLatest{
                
                APIClient.detailCarrier(carrierID: $0)
                    .do(onError:{ _ in
                        self.apiError.onNext("")
                    }).suppressError()
                
            }.map{try CarrierModel.parseJSON($0)}
            .asDriver(onErrorJustReturn: CarrierModel(carrier:nil,options:nil))
        
        
        completeCarrierInfo.flatMapLatest{
            APIClient.packageList(carrierID: $0.carrier?.carrierID ?? 0, sort: 0)
                .do(onError:{ _ in
                    self.apiError.onNext("")
                }).suppressError()
            }.map{ try PackageModel.parseJSON($0) }
            .asDriver(onErrorJustReturn: PackageModel(unCheck: nil,check:nil))
    }
}