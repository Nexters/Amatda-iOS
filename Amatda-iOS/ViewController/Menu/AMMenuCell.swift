//
//  AMMenuCell.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 23/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import SnapKit

enum AMMenuCellType {
    case carrier(String,Bool)
    case addCarrier
    case pushOption
    case termsOfService
}

class AMMenuCell : UITableViewCell{
    var selectionType : AMMenuCellType?{
        didSet{
            setupUI()
            setData()
        }
    }
    
    private var titleLabel       : UILabel = UILabel()
    private var pushSwitch       : UISwitch = UISwitch()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.font = UIFont.notoSansCJKKr_regular(fontSize: 13)
        titleLabel.textColor = UIColor(red: 51, green: 51, blue: 51)
        titleLabel.isHidden       = false
        pushSwitch.isHidden = true
    }
    
    
    private func setupUI(){
        self.addSubview(self.titleLabel)
        self.addSubview(self.pushSwitch)
        
        
        self.titleLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        
        self.pushSwitch.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-25)
        }
        
        self.pushSwitch.onTintColor = UIColor(red: 255, green: 84, blue: 0)
    }
    
    
    
    private func setData(){
        pushSwitch.isHidden = true
        
        guard let selectionType = selectionType else { return }
        switch selectionType {
        case .carrier(let title, let selection):
            titleLabel.text = title
            if selection {
                titleLabel.font = UIFont.notoSansCJKKr_medium(fontSize: 13)
                titleLabel.textColor = UIColor(red: 255, green: 84, blue: 0)
            }else{
                titleLabel.font = UIFont.notoSansCJKKr_regular(fontSize: 13)
                titleLabel.textColor = UIColor(red: 51, green: 51, blue: 51)
            }
            break
            
        case .addCarrier:
            titleLabel.text = "+  새 캐리어"
            titleLabel.font = UIFont.notoSansCJKKr_regular(fontSize: 13)
            titleLabel.textColor = UIColor(red: 51, green: 51, blue: 51)

            break
            
        case .pushOption:
            titleLabel.text = "푸시알림"
            pushSwitch.isHidden = false
            break
            
        case .termsOfService:
            titleLabel.text = "이용약관"
            break
        }
    }
    
    @objc private func pressedAddCarrier(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate?.window?.rootViewController = UINavigationController(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "AMMakeCarrierViewController") as! AMMakeCarrierViewController)
    }
}

