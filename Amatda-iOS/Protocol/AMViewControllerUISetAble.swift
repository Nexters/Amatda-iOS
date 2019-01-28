//
//  AMViewControllerUISetAble.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 19/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol AMViewControllerNaviSetAble  where Self : AMBaseViewController{
    var titleLabel                  : UILabel? { get set }
    var subTitleLabel           : UILabel? { get set }
    var rightBarButtonItem : UIBarButtonItem? { get set }
    
    func setupNavigation()
}

extension AMViewControllerNaviSetAble{
    func setupNavigation(){
        guard let titleLabel = titleLabel,
            let rightBarButtonItem = rightBarButtonItem else { return }
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(33.5)
            $0.left.equalToSuperview().offset(24)
        }
        
        if let subTitleLabel = subTitleLabel {
            subTitleLabel.numberOfLines = 0
            subTitleLabel.font = UIFont.systemFont(ofSize: 24)
            self.view.addSubview(subTitleLabel)
            subTitleLabel.snp.makeConstraints{
                $0.top.equalTo(titleLabel.snp.bottom)
                $0.left.equalTo(titleLabel)
            }
        }
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

protocol AMViewControllerBottomUISetAble where Self : AMBaseViewController {
    func setupBottom()
    func pressedCenterButton()
}


extension AMViewControllerBottomUISetAble {
    func setupBottom(){
        let bottomBackgroundView = UIView()
        let bottomToolbar                 = UIView()
        let centerButton                   = AMPlustButton()
        let leftButton                        = UIButton()
        let rightButton                      = UIButton()
        
        

        bottomToolbar.backgroundColor = .blue
        leftButton.backgroundColor        = .red
        rightButton.backgroundColor      = .red
        
        self.view.addSubview(bottomBackgroundView)
        bottomBackgroundView.addSubview(bottomToolbar)
        bottomBackgroundView.addSubview(centerButton)
        bottomToolbar.addSubview(leftButton)
        bottomToolbar.addSubview(rightButton)
        
        centerButton.addTarget(self, action: #selector(ViewController.pressedCenterButton), for: .touchDown)
        
        
        bottomBackgroundView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(AMDeviceInfo.bottomSafeAreaInset + 78)
        }
        
        bottomToolbar.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(AMDeviceInfo.bottomSafeAreaInset + 50)
        }
        
        centerButton.snp.makeConstraints{
            $0.size.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-10)
            $0.left.equalTo(24)
            $0.size.equalTo(30)
        }
        
        rightButton.snp.makeConstraints{
            $0.centerY.equalTo(leftButton.snp.centerY)
            $0.right.equalTo(-24)
            $0.size.equalTo(30)
        }
    }
}
