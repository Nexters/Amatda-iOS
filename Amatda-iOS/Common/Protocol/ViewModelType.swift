//
//  ViewModelType.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 19/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation


protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

