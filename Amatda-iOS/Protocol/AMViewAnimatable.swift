//
//  AMViewAnimatable.swift
//  Amatda-iOS
//
//  Created by JHH on 23/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit

protocol AMViewAnimatable where Self : AMBaseView {
    var contentViewHeight : CGFloat? { get set }
    var contentView       : UIView?  { get set }
    var backgroundView    : UIView?  { get set }
    
    func setupView()
    func onDragContentView(_ gesture : UIGestureRecognizer)
}

extension AMViewAnimatable{
    func setupView(){
        guard let backgroundView = self.backgroundView,
            let contentView = self.contentView else { return; }
        
        self.addSubview(backgroundView)
        self.addSubview(contentView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressedBackView(_:)))
        gesture.numberOfTapsRequired = 1
        
        backgroundView.addGestureRecognizer(gesture)
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    func onDragContentView(_ gesture : UIGestureRecognizer){
        guard let contentViewHeight = contentViewHeight,
            let contentView = contentView else { return }
        
        
        let point  = gesture.location(in: self)
        let height = self.frame.height
        
        if gesture.state == .changed {
            print("postion : \(gesture.location(in: self))")
            if point.y >= 0 && point.y <= height{
                let differ = (height - contentViewHeight) - point.y
                if differ > 0 {
                    contentView.snp.updateConstraints { (make) in
                        make.height.equalTo(differ + contentViewHeight)
                        print("\(differ + contentViewHeight)")
                    }
                }
            }
        }else if gesture.state == .ended {
            print("end")
            print("differ : \((height - contentViewHeight) * 5 / 10)")
            print("endPosition : \(point.y)")
            if point.y > (height - contentViewHeight) * 5 / 10{
                
                UIView.animate(withDuration: 0.3) {
                    contentView.snp.updateConstraints({ (make) in
                        make.height.equalTo(contentViewHeight)
                    })
                    self.layoutIfNeeded()
                }
            }else{
                UIView.animate(withDuration: 0.3) {
                    contentView.snp.updateConstraints({ (make) in
                        make.height.equalTo(height)
                    })
                    self.layoutIfNeeded()
                }
                
            }
            
        }
    }
}
