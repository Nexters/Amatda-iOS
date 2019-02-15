//
//  AMWriteView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import SnapKit
import DLRadioButton

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
        tf.placeholder = "준비물을 입력해주세요"
        tf.becomeFirstResponder()
        return tf
    }()
    
    
    lazy var labelTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "라벨"
        return label
    }()
    
    lazy var completeButton : UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    
    override func setupUI(){
        setupBaseView()
        self.layoutIfNeeded()
        self.backgroundColor = .clear
        setupInputTextField()
        setupLabelStackView()
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
            $0.right.equalToSuperview().offset(-26)
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
    
    
    private func setupLabelStackView(){
        let titleLabel = UILabel()
        titleLabel.text = "라벨"
        
        let labelStackView          = UIStackView()
        labelStackView.axis         = .horizontal;
        labelStackView.distribution = .equalSpacing;
        labelStackView.alignment    = .center;
        labelStackView.spacing      = 30;
        
        labelStackView.addArrangedSubview(titleLabel)
        let redRadio   = DLRadioButton()
        let blueRadio  = DLRadioButton()
        let greenRadio = DLRadioButton()
        
        redRadio.createRadioButton(size: 30, color: .red, superView: labelStackView)
        blueRadio.createRadioButton(size: 30, color: .blue, superView: labelStackView)
        greenRadio.createRadioButton(size: 30, color: .green, superView: labelStackView)
        
        redRadio.isSelected = true
        redRadio.otherButtons = [blueRadio, greenRadio]
        
        self.contentView?.addSubview(labelStackView)
        labelStackView.snp.makeConstraints{
            $0.top.equalTo(self.checkInputTextField.snp.bottom).offset(33)
            $0.left.equalTo(self.checkInputTextField.snp.left)
        }
    }
    
    private func setupCompleteButton(){
        
    }
    
}
