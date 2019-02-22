//
//  AMMenuView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 22/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMMenuView: AMBaseView, AMViewAnimatable {
    var contentViewHeight: CGFloat? = 296
    
    
    lazy var contentView : UIView? = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        contentView.addGestureRecognizer(gesture)
        
        return contentView
    }()
    
    
    
    lazy var backgroundView : UIView? = {
        let backView = UIView()
        backView.backgroundColor = .black
        backView.alpha = 0.2
        return backView
    }()
    
    
    
    private lazy var controller : AMMenuViewController? = {
        if self.vc is AMMenuViewController{
            return (self.vc as! AMMenuViewController)
        }
        
        return nil
    }()
    
    
    
    override func setupUI(){
        setupBaseView()
        self.layoutIfNeeded()
        self.backgroundColor = .clear
    }
    
    
    
    @objc private func dragView(_ gesture : UIGestureRecognizer){
        onDragContentView(gesture)
    }
    
}



extension AMMenuView : AMActionAnimate {
    func onWillPresentView(){
        backgroundView!.alpha = 0.0
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    
    func onWillDismissView(){
        backgroundView!.alpha = 0.4
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func performCustomPresentationAnimation(){
        backgroundView!.alpha = 0.4
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func performCustomDismissingAnimation(){
        backgroundView!.alpha = 0.0
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
}
