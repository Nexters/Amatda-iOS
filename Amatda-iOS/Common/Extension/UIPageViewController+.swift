//
//  UIPageViewController+.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 16/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {
    func enableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }
    
    func disableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}
