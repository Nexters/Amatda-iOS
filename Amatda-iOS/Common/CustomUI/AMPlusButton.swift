//
//  AMPlusButton.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 29/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit


private struct Constants{
    static let plusLineWidth   : CGFloat = 1.0
    static let plusButtonScale : CGFloat = 0.2
    static let halfPointShift  : CGFloat = 0.5
}


class AMPlustButton : UIButton {
    @IBInspectable var fillColor   : UIColor = UIColor(red: 255, green: 217, blue: 0, alpha: 1)
    
    private var halfWidth : CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight : CGFloat{
        return bounds.height / 2
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        
        let plusWidth : CGFloat = min(bounds.width,bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth,
                                  y: halfHeight))
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth,
                                     y: halfHeight))
        
        
        
        plusPath.move(to: CGPoint(x: halfWidth,
                                  y: halfHeight - halfPlusWidth))
        plusPath.addLine(to: CGPoint(x: halfWidth,
                                     y: halfHeight + halfPlusWidth))
        
        
        UIColor.lightGray.setStroke()
        plusPath.stroke()
    }
}
