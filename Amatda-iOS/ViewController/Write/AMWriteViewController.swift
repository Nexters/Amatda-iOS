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

class AMWriteViewController: AMPresentAnimateViewController {
    
    private lazy var writeView = AMWriteView(controlBy : self)
    lazy var disposeBag = DisposeBag()
    
    //input
    let didTapCompleteButton = PublishSubject<Void>()
    let checkInputText       = BehaviorSubject(value: "")
    let labelColorTag        = BehaviorSubject(value: 0)
    
    //output
    var registerCheckItem    : Driver<String>?
    var isEmptyInputText     = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupObservable()
        self.modalPresentationStyle = .overCurrentContext
    }
    
    
    private func setupObservable(){
        let register = Observable.combineLatest(self.labelColorTag, self.checkInputText) { ($0,$1) }
        let emptyObservable = self.checkInputText.map{ $0.count == 0 }
        
        self.didTapCompleteButton
            .withLatestFrom(register)
            .subscribe(onNext:{ s1 in
                print("s1 : \(s1)")
            }).disposed(by: disposeBag)
        
        
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
