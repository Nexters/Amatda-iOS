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
        
        titleLabel.font = UIFont.notoSansCJKKr_medium(fontSize: 14)
        titleLabel.textColor = UIColor(red: 255, green: 84, blue: 0)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.left
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
}

protocol AMViewControllerBottomUISetAble where Self : AMBaseViewController {
    func setupBottom()
    var leftButton : UIButton? { get set }
    var rightButton : UIButton? { get set }
    var centerButton : AMPlustButton? { get set }
    
}


extension AMViewControllerBottomUISetAble {
    func setupBottom(){
        let bottomBackgroundView = UIView()
        let bottomToolbar        = UIView()
        
        guard let centerButton = centerButton,
                   let leftButton = leftButton,
                   let rightButton = rightButton
            else {
                return
        }
        
        

        bottomToolbar.backgroundColor = .blue
        leftButton.backgroundColor        = .red
        rightButton.backgroundColor      = .red
        
        self.view.addSubview(bottomBackgroundView)
        bottomBackgroundView.addSubview(bottomToolbar)
        bottomBackgroundView.addSubview(centerButton)
        bottomToolbar.addSubview(leftButton)
        bottomToolbar.addSubview(rightButton)
        
        
        
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
