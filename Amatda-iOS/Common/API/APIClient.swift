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

func apiError(_ error: String) -> NSError {
    return NSError(domain: "Amatda API", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
}

class APIClient {
    static func registerCarrier(countryID : Int,
                                startDate : String,
                                options   : [Int])->Observable<Int>{
        return Observable.create{ emit in
            Alamofire.request(APIRouter.registerCarrier(countryID: countryID, startDate: startDate, options: options)).responseSwiftyJSON(completionHandler: { (jsonData) in
                
                switch jsonData.result{
                case .success(let data):
                    emit.onNext(data.intValue)
                    emit.onCompleted()
                    break
                case .failure(let error):
                    emit.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
    }
    
    
    static func detailCarrier(carrierID : Int)->Observable<JSON>{
        return rxJSONAPIObservable(url: APIRouter.detailCarrier(carrierID: carrierID))
    }
    

    static func packageList(carrierID : Int, sort: Int)->Observable<JSON>{
        return rxJSONAPIObservable(url: APIRouter.packageList(carrierID: carrierID, sort: sort))
    }
    
    
    static func rxJSONAPIObservable(url : URLRequestConvertible)->Observable<JSON>{
        return Observable.create{ emit in
            Alamofire.request(url)
                .responseSwiftyJSON(completionHandler: { (jsonData) in
                    switch jsonData.result{
                    case .success(let data):
                        emit.onNext(data)
                        emit.onCompleted()
                        break
                    case .failure(let error):
                        emit.onError(error)
                        break
                    }
                })
            return Disposables.create()
        }
    }
}
