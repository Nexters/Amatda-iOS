//
//  AMDeviceInfo.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 29/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit

struct AMDeviceInfo {
    static var isIphoneX : Bool{
        get{
            if #available(iOS 11.0, *) {
                if topSafeAreaInset > CGFloat(0) {
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        }
    }
    
    static var topSafeAreaInset : CGFloat{
        let window = UIApplication.shared.keyWindow
        var topPadding : CGFloat = 0
        if #available(iOS 11.0, *) {
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        
        return topPadding
    }
    
    static var bottomSafeAreaInset : CGFloat{
        let window = UIApplication.shared.keyWindow
        var bottomPadding : CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
        }
        
        return bottomPadding
    }
}
