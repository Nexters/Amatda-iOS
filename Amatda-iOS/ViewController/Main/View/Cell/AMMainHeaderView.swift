//
//  AMMainHeaderView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 08/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import SnapKit

let mainHeaderView = "AMMainHeaderView"

class AMMainHeaderView: UICollectionReusableView {
    private lazy var cityLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.notoSansCJKKr_regular(fontSize: 12)
        lb.textColor = UIColor(red: 51, green: 51, blue: 51)
        
        return lb
    }()
    
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 2
        lb.font = UIFont.notoSansCJKKr_regular(fontSize: 24)
        lb.textColor = UIColor(red: 51, green: 51, blue: 51)
        
        return lb
    }()
    
    var carrierName : String? {
        didSet{
            let attr = NSMutableAttributedString(string:"\(carrierName ?? "")에\n무엇을 챙길까요?")
            attr.setColorForText(textForAttribute: carrierName ?? "", withColor: UIColor(red: 255, green: 84, blue: 0))
            self.titleLabel.attributedText = attr
        }
    }
    
    var cityName : String?{
        didSet{
            self.cityLabel.text = self.cityName ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        
        self.addSubview(self.cityLabel)
        self.addSubview(self.titleLabel)
        
        self.cityLabel.text = "교토"
        self.titleLabel.text = "캐리어 1에\n무엇을 챙길까요?"
        
        self.cityLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(35)
        }
        
        self.titleLabel.snp.makeConstraints{
            $0.left.equalTo(self.cityLabel.snp.left)
            $0.top.equalTo(self.cityLabel.snp.bottom)
        }
        
        let attr = NSMutableAttributedString(string:"캐리어 1에\n무엇을 챙길까요?")
        attr.setColorForText(textForAttribute: "캐리어 1", withColor: UIColor(red: 255, green: 84, blue: 0))
        self.titleLabel.attributedText = attr
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



