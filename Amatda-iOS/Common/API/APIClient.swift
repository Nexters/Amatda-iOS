//
//  APIClient.swift
//  Amatda-iOS
//
//  Created by JHH on 19/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import SwiftyJSON
import RxSwift

class APIClient {
//    case registerCarrier(countryID : Int, startDate : String ,options : [Int])
    static func registerCarrier(countryID : Int,
                                startDate : String,
                                options   : [Int])->Observable<Bool>{
        return Observable.create{ emit in
            
            
            return Disposable.create()
        }
    }
}
