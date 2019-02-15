//
//  UIFont+.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 15/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit


/*
 ["NotoSansCJKkr-Black", "NotoSansCJKkr-Bold", "NotoSansCJKkr-Thin", "NotoSansCJKkr-Regular", "NotoSansCJKkr-Light", "NotoSansCJKkr-DemiLight", "NotoSansCJKkr-Medium"]
 */
extension UIFont{
    static func notoSansCJKKr_black(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-Black", size: size)!
    }
    
    static func notoSansCJKKr_bold(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-Bold", size: size)!
    }
    
    static func notoSansCJKKr_thin(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-Thin", size: size)!
    }
    
    static func notoSansCJKKr_regular(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-Regular", size: size)!
    }
    
    static func notoSansCJKKr_light(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-Light", size: size)!
    }
    
    static func notoSansCJKKr_demiLight(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-DemiLight", size: size)!
    }
    
    static func notoSansCJKKr_medium(fontSize size : CGFloat)->UIFont{
        return UIFont(name: "NotoSansCJKkr-Medium", size: size)!
    }
}

