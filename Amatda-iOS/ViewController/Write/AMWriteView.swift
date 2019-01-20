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

    lazy var backgroundView : UIView = {
        let backView = UIView(frame: self.frame)
        backView.backgroundColor = .blue
        backView.alpha = 0.2
        return backView
    }()
    
    override func setupUI(){
        
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        self.backgroundColor = .clear
    }
}
