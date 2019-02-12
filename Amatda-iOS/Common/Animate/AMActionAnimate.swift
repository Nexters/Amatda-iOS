//
//  AMActionAnimate.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

protocol AMActionAnimate{
    func onWillPresentView()
    func onWillDismissView()
    func performCustomPresentationAnimation()
    func performCustomDismissingAnimation()
}
