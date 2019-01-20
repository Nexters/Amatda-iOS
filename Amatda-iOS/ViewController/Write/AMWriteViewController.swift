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
    
    override func loadView() {
        view = v
    }
    
    override func onWillPresentView(){
        //overide
        
    }
    
    override func onWillDismissView(){
        //overide
        
    }
    
    override func performCustomPresentationAnimation(){
        //overide
        
    }
    
    override func performCustomDismissingAnimation(){
        //overide
        
    }
}
