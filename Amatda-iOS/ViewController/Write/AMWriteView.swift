//
//  AMWriteView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import SnapKit

class AMWriteView: AMBaseView {
    private lazy var backgroundView : UIView = {
        let backView = UIView(frame: self.frame)
        backView.backgroundColor = .blue
        backView.alpha = 0.2
        return backView
    }()
    
    private lazy var contentView : UIView = {
        let contentView = UIView(frame: self.frame)
        contentView.backgroundColor = .white
        return contentView
    }()
    
    override func setupUI(){
        self.addSubview(backgroundView)
        self.addSubview(contentView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressedBackView(_:)))
        gesture.numberOfTapsRequired = 1
        self.backgroundView.addGestureRecognizer(gesture)
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        self.backgroundColor = .white
    }
    
    
    @objc private func pressedBackView(_ gestureRecognizer: UIPanGestureRecognizer){
        vc.dismiss(animated: true, completion: nil)
    }
}

extension AMWriteView : AMActionAnimate {
    func onWillPresentView(){
        backgroundView.alpha = 0.0
        contentView.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    
    func onWillDismissView(){
        backgroundView.alpha = 0.4
        contentView.snp.updateConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func performCustomPresentationAnimation(){
        backgroundView.alpha = 0.4
        contentView.snp.updateConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func performCustomDismissingAnimation(){
        backgroundView.alpha = 0.0
        contentView.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
}
