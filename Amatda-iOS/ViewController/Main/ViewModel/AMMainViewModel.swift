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
    let tapCheckPackage     = PublishSubject<Package>()
    
    //output
    var detailCarrier        : Driver<CarrierModel>?
    var packageList          : Driver<PackageModel>?
    var completeCheckPackage : Driver<Int>?
    
    let apiError = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    init() {
        setup()
    }
    
    
    private func setup(){
        self.detailCarrier = self.viewDidLoad
            .debug("detailCarrier")
            .flatMapLatest{
                
                APIClient.detailCarrier(carrierID: $0)
                    .do(onError: {_ in
                        self.apiError.onNext("")
                    }, onCompleted: {
                        print("dddd")
                    }).suppressError()
                
            }.map{
                try CarrierModel.parseJSON($0)
            }
            .asDriver(onErrorJustReturn: CarrierModel(carrier:nil,options:nil))
        
        
        
        self.packageList = self.completeCarrierInfo
            .flatMapLatest{
                
                APIClient.packageList(carrierID: $0.carrier?.carrierID ?? 0, sort: 0)
                    .do(onError:{ _ in
                        self.apiError.onNext("")
                    }).suppressError()
                
            }.map{
                try PackageModel.parseJSON($0)
            }
            .asDriver(onErrorJustReturn: PackageModel(unCheck: nil,check:nil))
        
        
        
        self.tapCheckPackage.flatMapLatest{
            APIClient.checkPackage(packageID: $0.packageID, check: !$0.check)
                .do(onError:{ _ in
                    self.apiError.onNext("")
                }).suppressError()
            }.subscribe(onNext:{ s in
                print("result : \(s)")
            }).disposed(by: disposeBag)
        
    }
}
