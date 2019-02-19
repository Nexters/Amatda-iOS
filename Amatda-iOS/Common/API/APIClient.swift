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
import Alamofire
import Alamofire_SwiftyJSON

class APIClient {
    static func registerCarrier(countryID : Int,
                                startDate : String,
                                options   : [Int])->Observable<Bool>{
        return Observable.create{ emit in
            Alamofire.request(APIRouter.registerCarrier(countryID: countryID, startDate: startDate, options: options)).responseSwiftyJSON(completionHandler: { (jsonData) in
                
                print("result : \(jsonData.value)")
                emit.onNext(true)
                emit.onCompleted()
                
            })
            return Disposables.create()
        }
    }
}
