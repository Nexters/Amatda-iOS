//
//  AMBaseView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMBaseView: UIView {
    // MARK: Properties
    weak var vc: AMBaseViewController!
    
    // MARK: Initialize
    required init(controlBy viewController: AMBaseViewController) {
        vc = viewController
        super.init(frame: UIScreen.main.bounds)
        setupUI()
        setupBinding()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // Override
    }
    
    func setupBinding() {
        // Override
    }
    
    // MARK: Deinit
    deinit {

    }
    
    @objc func pressedBackView(_ gestureRecognizer: UIPanGestureRecognizer){
        vc.dismiss(animated: true, completion: nil)
    }
}
