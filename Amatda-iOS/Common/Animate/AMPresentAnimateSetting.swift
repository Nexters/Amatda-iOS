//
//  AMPresentAnimateSetting.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit

struct AMPresentAnimateSetting {
    
    struct AnimationStyle{
        public var scale: CGSize? = nil
        public var present = PresentAnimationStyle()
        public var dismiss = DismissAnimationStyle()
    }
    
    
    struct PresentAnimationStyle {
        
        public var damping = CGFloat(1.0)
        public var delay = TimeInterval(0.0)
        public var duration = TimeInterval(0.4)
        public var springVelocity = CGFloat(0.0)
        public var options = UIView.AnimationOptions.curveLinear
    }
    
    
    struct DismissAnimationStyle {
        public var damping = CGFloat(1.0)
        public var delay = TimeInterval(0.0)
        public var duration = TimeInterval(0.4)
        public var springVelocity = CGFloat(0.0)
        public var options = UIView.AnimationOptions.curveLinear
        public var offset = CGFloat(0)
    }
    
    public var animation      = AnimationStyle()
    
    public static func defaultSettings() -> AMPresentAnimateSetting{
        return AMPresentAnimateSetting()
    }
}
