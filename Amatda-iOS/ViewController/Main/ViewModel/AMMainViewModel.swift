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

final class AMMainViewModel: ViewModelType{
    struct Input {
        let trigger      : Driver<Int> //viewDidLoad
        let triggerCheck : Driver<Package>
    }
    
    struct Output {
        let packages : Driver<[SectionOfPackage]>?
        let doCheck  : Driver<Int>?
        let apiError : Driver<String>?
    }
    
    private let useCase   : MainCase
    private let navigator : AMMainNavigator
    
    
    //input
    let viewDidLoad         = PublishSubject<Int>()
    let completeCarrierInfo = PublishSubject<CarrierModel>()
    let tapCheckPackage     = PublishSubject<Package>()
    
    //output
    var detailCarrier        : Driver<CarrierModel>?
    var packageList          : Driver<[SectionOfPackage]>?
    var checkPackage         : Driver<Int>?
    
    let apiError = PublishSubject<String>()
    
//    init() {
//        setup()
//    }
    
    init(useCase: MainCase, navigator: AMMainNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input)->Output{
        let packages = input.trigger.map{ _ in
                self.useCase.postAll()
            }.flatMapLatest{ _ in
            APIClient.packageList(carrierID: 0, sort: 0)
                .do(onError:{ [weak self] _ in
                    guard let self = self else { return }
                    self.apiError.onNext("")
                }).suppressError()
            }.map{
                try PackageModel.parseJSON($0)
            }.asDriverOnErrorJustComplete()
        
        
        let doCheck = input.triggerCheck.flatMapLatest{
            APIClient.checkPackage(packageID: $0.packageID, check: !$0.check)
                .do(onError:{ [weak self] _ in
                    guard let self = self else { return }
                    self.apiError.onNext("")
                }).suppressError()
            }.map{_ in 0}.asDriverOnErrorJustComplete()
        
        return Output(packages: packages,
                      doCheck: doCheck)
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
