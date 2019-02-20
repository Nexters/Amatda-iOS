//
//  String+.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 16/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit

extension String{
    static let emptyCheckItem = "준비물을 입력해주시기 바랍니다."
    static let errorString    = "알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요."
}


extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
