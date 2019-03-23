//
//  AMWriteViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class AMWriteViewController: AMPresentAnimateViewController {
    
    private lazy var writeView = AMWriteView(controlBy : self)
    lazy var disposeBag = DisposeBag()
    var packageID = 0
    
    //input
    let didTapCompleteButton = PublishSubject<Void>()
    let deleteTapButton      = PublishSubject<Void>()
    let checkInputText       = BehaviorSubject(value: "")
    let labelColorTag        = BehaviorSubject(value: "Gray")
    let currentCarrier       = PublishSubject<CarrierModel>()
    var writeEventBus        : Driver<Void>?
    var editEventBus         : Driver<Void>?
    
    //output
    var registerCheckItem    : Driver<String>?
    var isEmptyInputText     = PublishSubject<Bool>()
    var carrierItem          : Carrier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupObservable()
        self.modalPresentationStyle = .overCurrentContext
    }
    
    convenience init(packageID : Int){
        self.init()
        self.packageID = packageID
    }
    
    
    private func setupObservable(){
        
        let register = Observable.combineLatest(self.labelColorTag,
                                                self.checkInputText
                                                ) { (self.carrierItem?.carrierID ?? 0,$0,$1) }
        let emptyObservable = self.checkInputText.map{ $0.count == 0 }
        
        
        self.writeEventBus = self.didTapCompleteButton
            .withLatestFrom(register)
            .flatMapLatest{
                APIClient.registerPackage(carrierID: $0, packageName: $2, labelColor: $1)
            }.do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: nil)
            })
            .map{ _ in return () }.asDriver(onErrorJustReturn: ())
        
        
        let completeEvent = self.didTapCompleteButton
            .withLatestFrom(register)
            .flatMapLatest{
                APIClient.editPackage(packageID: self.packageID, packageName: $2, packageColor: $1)
        }
        
        let deleteEvent = self.deleteTapButton
            .flatMapLatest{
                APIClient.deletePackage(packageID: self.packageID)
        }.debug("deleteEvent")
        
        self.editEventBus = Observable.merge(completeEvent,deleteEvent).debug("editEventBusObservable")
            .do(onNext:{
            [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)            
        }).map{ _ in ()}.asDriver(onErrorJustReturn: ())
        
        
        self.didTapCompleteButton
            .withLatestFrom(emptyObservable)
            .filter{$0}
            .bind(to: self.isEmptyInputText)
            .disposed(by: disposeBag)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = self.writeView
    }
    
    
    override func onWillPresentView(){
        self.writeView.onWillPresentView()
    }
    
    
    override func onWillDismissView(){
        self.writeView.onWillDismissView()
    }
    
    
    override func performCustomPresentationAnimation(){
        self.writeView.performCustomPresentationAnimation()
    }
    
    
    override func performCustomDismissingAnimation(){
        self.writeView.performCustomDismissingAnimation()
    }
}


extension AMWriteViewController{
    func convertColorTag(_ index : Int)->String{
        switch index {
        case 0:
            return "Gray"
        case 1:
            return "Red"
        case 2:
            return "Blue"
        case 3:
            return "Green"
        default:
            return ""
        }
    }
    
    
    func convertColorString(_ colorLabel : String)->Int{
        switch colorLabel {
        case "Gray":
            return 0
        case "Red":
            return 1
        case "Blue":
            return 2
        case "Green":
            return 3
        default:
            return 0
        }
    }
}
