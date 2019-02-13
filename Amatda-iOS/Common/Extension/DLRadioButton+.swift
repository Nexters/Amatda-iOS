//
//  DLRadioButton+.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 14/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import DLRadioButton
import SnapKit

extension DLRadioButton {
    func createRadioButton(size : Int, color : UIColor, superView : UIStackView){
        self.iconColor = color
        self.isIconSquare = true
        self.indicatorColor = color;
        self.indicatorSize = self.iconSize
        
        superView.addArrangedSubview(self)
        
        self.snp.makeConstraints{
            $0.size.equalTo(size)
        }
    }
}
