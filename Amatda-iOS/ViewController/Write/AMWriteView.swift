//
//  AMWriteView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import SnapKit

class AMWriteView: AMBaseView, AMViewAnimatable {
    var contentViewHeight: CGFloat? = 400
    
    
    lazy var backgroundView : UIView? = {
        let backView = UIView()
        backView.backgroundColor = .black
        backView.alpha = 0.2
        return backView
    }()
    
    
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
    
    
    lazy var checkInputTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "체크리스트를 입력해주세요"
        
        return tf
    }()
    
    
    lazy var labelTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "라벨"
        return label
    }()
    
    
    override func setupUI(){
        setupBaseView()
        self.layoutIfNeeded()
        self.backgroundColor = .clear
        setupInputTextField()
    }
    
    
    
    @objc private func dragView(_ gesture : UIGestureRecognizer){
        onDragContentView(gesture)
    }
}

extension AMWriteView : AMActionAnimate {
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


extension AMWriteView{
    private func setupInputTextField(){
        self.contentView?.addSubview(self.checkInputTextField)
        self.contentView?.addSubview(self.labelTitleLabel)
        
        self.checkInputTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.left.equalToSuperview().offset(24)
        }
        
        let lineView = UIView()
        self.contentView?.addSubview(lineView)
        lineView.backgroundColor = .red
        lineView.snp.makeConstraints{
            $0.top.equalTo(self.checkInputTextField.snp.bottom).offset(3)
            $0.left.equalTo(self.checkInputTextField.snp.left)
            $0.right.equalTo(self.checkInputTextField.snp.right)
            $0.height.equalTo(1)
        }
    }
    
    
    
    
}
