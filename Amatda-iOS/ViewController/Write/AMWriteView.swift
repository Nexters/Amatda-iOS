//
//  AMWriteView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import DLRadioButton
import RxCocoa
import RxSwift
import SnapKit



class AMWriteView: AMBaseView, AMViewAnimatable {
    var contentViewHeight: CGFloat? {
        return (appDelegate?.keyboardHeight ?? 0) + 190
    }
    
    
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
    
    
    private lazy var controller : AMWriteViewController? = {
        if self.vc is AMWriteViewController{
            return (self.vc as! AMWriteViewController)
        }
        
        return nil
    }()
    
    
    private lazy var checkInputTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "준비물을 입력해주세요"
        tf.font = UIFont.notoSansCJKKr_regular(fontSize: 16)
        tf.becomeFirstResponder()
        
        if let controller = controller {
            tf.rx.text.orEmpty.scan("") {
                if $1.count > 10 {
                    return $0 ?? String($1.prefix(10))
                }else{
                    return $1
                }
                }.subscribe(tf.rx.text)
                .disposed(by: controller.disposeBag)
        }

        return tf
    }()
    
    
    private lazy var labelStackView : UIStackView = {
        let labelStackView          = UIStackView()
        labelStackView.axis         = .horizontal;
        labelStackView.distribution = .equalSpacing;
        labelStackView.alignment    = .center;
        labelStackView.spacing      = 30;
        labelStackView.backgroundColor = .red
        
        return labelStackView
    }()
    
    
    private lazy var completeButton : UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = UIFont.notoSansCJKKr_bold(fontSize: 15)
        button.setTitleColor(UIColor.init(red: 255, green: 84, blue: 0), for: .normal)
        return button
    }()
    
    
    override func setupUI(){
        setupBaseView()
        setupInputTextField()
        setupLabelStackView()
        setupCompleteButton()
        
        self.layoutIfNeeded()
        self.backgroundColor = .clear
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
        
        self.checkInputTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.left.equalToSuperview().offset(24)
        }

        let lineView = UIView()
        self.contentView?.addSubview(lineView)
        lineView.backgroundColor = UIColor(red: 179, green: 179, blue: 179)
        lineView.snp.makeConstraints{
            $0.top.equalTo(self.checkInputTextField.snp.bottom).offset(3)
            $0.left.equalTo(self.checkInputTextField.snp.left)
            $0.right.equalTo(self.checkInputTextField.snp.right).offset(50)
            $0.height.equalTo(1)
        }
    }
    
    
    private func setupLabelStackView(){
        let titleLabel = UILabel()
        titleLabel.text = "라벨"
        titleLabel.font = UIFont.notoSansCJKKr_regular(fontSize: 16)
        titleLabel.textColor = UIColor(red: 155, green: 155, blue: 155)
        
        self.labelStackView.addArrangedSubview(titleLabel)
        
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
        self.contentView?.addSubview(self.completeButton)
        
        self.completeButton.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-23)
            $0.size.equalTo(40)
            $0.top.equalTo(self.labelStackView.snp.bottom).offset(28)
        }
    }
    
}
