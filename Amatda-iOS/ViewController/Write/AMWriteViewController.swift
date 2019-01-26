//
//  AMWriteViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMWriteViewController: AMPresentAnimateViewController {
    
    private lazy var v = AMWriteView(controlBy : self)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = v
    }
    
    override func onWillPresentView(){
        v.onWillPresentView()
    }
    
    override func onWillDismissView(){
        v.onWillDismissView()
    }
    
    override func performCustomPresentationAnimation(){
        v.performCustomPresentationAnimation()
    }
    
    override func performCustomDismissingAnimation(){
        v.performCustomDismissingAnimation()
    }
}
