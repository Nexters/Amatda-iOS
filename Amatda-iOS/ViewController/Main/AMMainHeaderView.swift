//
//  AMMainHeaderView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 08/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

let mainHeaderView = "AMMainHeaderView"

class AMMainHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
