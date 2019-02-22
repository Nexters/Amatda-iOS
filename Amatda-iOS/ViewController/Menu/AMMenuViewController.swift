//
//  AMMenuViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 22/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMMenuViewController: AMPresentAnimateViewController {

    private lazy var menuView = AMMenuView(controlBy : self)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func loadView() {
        view = self.menuView
    }
    
    
    override func onWillPresentView(){
        self.menuView.onWillPresentView()
    }
    
    
    override func onWillDismissView(){
        self.menuView.onWillDismissView()
    }
    
    
    override func performCustomPresentationAnimation(){
        self.menuView.performCustomPresentationAnimation()
    }
    
    
    override func performCustomDismissingAnimation(){
        self.menuView.performCustomDismissingAnimation()
    }
}
