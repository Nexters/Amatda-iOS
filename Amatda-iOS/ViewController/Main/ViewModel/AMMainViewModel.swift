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
    var packageList          : Driver<[SectionOfPackage]>?
    var completeCheckPackage : Driver<Int>?
    var checkPackage         : Driver<Int>?
    
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
                    .do(onError: { [weak self] _ in
                        guard let self = self else { return }
                        self.apiError.onNext("")
                    }).suppressError()
                
            }.map{
                try CarrierModel.parseJSON($0)
            }
            .asDriver(onErrorJustReturn: CarrierModel(carrier:nil,options:nil))
        
        
        
        self.packageList = self.completeCarrierInfo
            .flatMapLatest{ _ in
                
//                APIClient.packageList(carrierID: $0.carrier?.carrierID ?? 0, sort: 0)
                APIClient.packageList(carrierID: 0, sort: 0)
                    .do(onError:{ [weak self] _ in
                        guard let self = self else { return }
                        self.apiError.onNext("")
                    }).suppressError()
                
            }.map{
                try PackageModel.parseJSON($0)
            }
            .asDriver(onErrorJustReturn: [])
        
        
        
        
        self.checkPackage = self.tapCheckPackage.flatMapLatest{
            APIClient.checkPackage(packageID: $0.packageID, check: !$0.check)
                .do(onError:{ [weak self] _ in
                    guard let self = self else { return }
                    self.apiError.onNext("")
                }).suppressError()
            }.map{_ in 0}
            .asDriver(onErrorJustReturn: 0)
    }
}
