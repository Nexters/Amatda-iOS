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
    var contentViewHeight : CGFloat? { get }
    var contentView       : UIView?  { get set }
    var backgroundView    : UIView?  { get set }
    
    func setupBaseView()
    func onDragContentView(_ gesture : UIGestureRecognizer)
}


extension AMViewAnimatable{
    func setupBaseView(){
        guard let backgroundView = self.backgroundView,
            let contentView = self.contentView else { return; }
        
        self.addSubview(backgroundView)
        self.addSubview(contentView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressedBackView(_:)))
        gesture.numberOfTapsRequired = 1
        
        backgroundView.addGestureRecognizer(gesture)
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0)
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
            
            UIView.animate(withDuration: 0.3) {
                contentView.snp.updateConstraints({ (make) in
                    make.height.equalTo(contentViewHeight)
                })
                self.layoutIfNeeded()
            }
        }
    }
}
