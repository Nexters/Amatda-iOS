//
//  PostsUseCase.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 11/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import RxSwift

public protocol CarrierUseCase{
    func post()    -> Observable<[Carrier]>
    func save()    -> Observable<Void>
    func delete()  -> Observable<Void>
}


