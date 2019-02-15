//
//  AMWriteViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMWriteViewController: AMPresentAnimateViewController {
    
    
    
    private lazy var writeView = AMWriteView(controlBy : self)
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
