//
//  AMPackageCell.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 22/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class AMPackageCell: UICollectionViewCell {
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    var packageItem : Package? {
        didSet{
            setupUI()
            setData()
        }
    }
    
    var checkButton    = UIButton()
    var packageLabel   = UILabel()
    var recommendLabel = UILabel()
    
    
    private func setupUI(){
        self.addSubview(self.checkButton)
        self.addSubview(self.packageLabel)
        self.addSubview(self.recommendLabel)
        
        self.packageLabel.font        = UIFont.notoSansCJKKr_regular(fontSize: 16)
        self.recommendLabel.font      = UIFont.notoSansCJKKr_regular(fontSize: 11)
        self.packageLabel.textColor   = UIColor(red: 51, green: 51, blue: 51)
        self.recommendLabel.textColor = UIColor(red: 51, green: 51, blue: 51)
        
        
        self.checkButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(24)
            $0.size.equalTo(20)
        }
        
        self.packageLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.checkButton.snp.centerY)
            $0.left.equalTo(self.checkButton.snp.right).offset(21)
        }
        
        self.recommendLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.checkButton.snp.centerY)
            $0.right.equalToSuperview().offset(23)
        }
    }
    
    
    private func setData(){
        guard let package = self.packageItem else { return }
        self.packageLabel.text = package.packageName
        self.recommendLabel.text = "추천"
        self.checkButton.setImage(convertCheckImage(package: package), for: .normal)
    }
    
    
    private func convertCheckImage(package : Package)->UIImage{
        var imageNamed = ""
        if package.check {
            self.checkButton.isEnabled = false
            switch package.packageColor {
            case "Black":
                imageNamed = "checkDefault"
                break
                
            case "Green":
                imageNamed = "checkGreen"
                break
                
            case "Blue":
                imageNamed = "checkViolet"
                break
                
            case "Red":
                imageNamed = "checkPink"
                break
                
            default:
                imageNamed = "checkDefault"
                break
            }
        }else{
            self.checkButton.isEnabled = true
            switch package.packageColor {
            case "Black":
                imageNamed = "labelDefault"
                break
                
            case "Green":
                imageNamed = "labelGreen"
                break
                
            case "Blue":
                imageNamed = "labelViolet"
                break
                
            case "Red":
                imageNamed = "labelPink"
                break
                
            default:
                imageNamed = "labelDefault"
                break
            }
        }
        
        return UIImage(named: imageNamed)!
    }
}
