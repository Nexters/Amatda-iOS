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
        let carrier  : Driver<Carrier>?
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
    
    
    init(useCase: MainCase, navigator: AMMainNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input)->Output{
        let carriers = input.trigger.debug("carriers").flatMapLatest{ _ in
            self.useCase.postAll().asDriverOnErrorJustComplete()
        }
        
        let carrier = Driver.combineLatest(carriers.filter{ $0.count > 0 },
                                           input.trigger){ carriers, index in
            carriers[index]
        }
        let packages = carrier.map{ $0.parse() }
        let doCheck  = input.triggerCheck.map{ _ in 1  }
        let apiError = input.triggerCheck.map{ _ in "" }
        
        return Output(carrier : carrier,
                      packages: packages,
                      doCheck : doCheck,
                      apiError: apiError)
    }
}
