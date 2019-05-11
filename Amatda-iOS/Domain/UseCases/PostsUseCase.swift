//
//  PostsUseCase.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 11/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostsUseCase{
    func post()                 -> Observable<Void>
    func createCarrierPost()    -> Observable<Void>
    func createCheckItemPost()  -> Observable<Void>
}


