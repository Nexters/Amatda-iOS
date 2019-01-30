//
//  ViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class AMMainViewController: AMBaseViewController, AMViewControllerNaviSetAble, AMViewControllerBottomUISetAble {
    var leftButton: UIButton? = UIButton()
    var rightButton: UIButton? = UIButton()
    var centerButton: AMPlustButton? = AMPlustButton()
    
    var titleLabel: UILabel? = UILabel()
    var subTitleLabel           : UILabel? = UILabel()
    var rightBarButtonItem: UIBarButtonItem? = UIBarButtonItem()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        titleLabel?.text = "나고야"
        subTitleLabel?.text = "햇빵이에\n무엇을 챙길까요?"

        setupNavigation()
        setupBottom()
    }
    
    override func setupBind() {
        super.setupBind()

        let viewModel = AMMainViewModel()
        
        self.centerButton?.rx.tap
            .asObservable()
            .bind (to:viewModel.didTap)
            .disposed(by: disposeBag)
        
        viewModel.didTap
            .subscribe( onNext : { [weak self] in
            self?.pressedCenterButton()
            }).disposed(by: disposeBag)
        
        
        
    }
    
    @objc func pressedCenterButton() {
        let viewController2 = AMWriteViewController()
        viewController2.modalPresentationStyle = .overCurrentContext
        viewController2.view.backgroundColor    = .clear
        self.present(viewController2, animated: true, completion: nil)
    }
}

