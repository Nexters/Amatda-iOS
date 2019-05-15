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
                                options   : [Int])->Observable<Carrier>{
        return Observable.create{ emit in
            Alamofire.request(APIRouter.registerCarrier(countryID: countryID,
                                                        startDate: startDate,
                                                        options: options))
                .responseSwiftyJSON(completionHandler: { (jsonData) in
                
                switch jsonData.result{
                case .success(let data):
                    
                    let carrier = Carrier(startDate: startDate,
                                          countryName: cities[countryID],
                                          carrierID: data.intValue)
//                    let carrier = Carrier(carrierID: data.intValue,
//                                          startDate: startDate,
//                                          carrierName: "캐리어 \(AMCarrierStack().count + 1)",
//                                          carrierCountryID: countryID,
//                                          countryName : cities[countryID]
//                    )
                    
                    emit.onNext(carrier)
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
    
    static func checkPackage(packageID : Int, check : Bool)->Observable<JSON>{
        return rxJSONAPIObservable(url: APIRouter.checkPackage(packageID: packageID, check: check ? "Y":"N"))
    }
    
    static func registerPackage(carrierID : Int, packageName:String, labelColor : String)->Observable<JSON>{
        return rxJSONAPIObservable(url: APIRouter.registerPackage(carrierID: carrierID, packageName: packageName, labelColor: labelColor, check: "N"))
    }
    
    static func editPackage(packageID : Int,packageName : String, packageColor:String)->Observable<JSON>{
        return rxJSONAPIObservable(url: APIRouter.editPackage(packageID: packageID,
                                                              packageName: packageName,
                                                              labelColor: packageColor))
    }
    
    static func deletePackage(packageID : Int)->Observable<JSON>{
        return rxJSONAPIObservable(url: APIRouter.deletePackage(packageID: packageID))
    }
    
    
    static func rxJSONAPIObservable(url : URLRequestConvertible)->Observable<JSON>{
        return Observable.create{ emit in
            Alamofire.request(url)
                .responseSwiftyJSON(completionHandler: { (jsonData) in
                    print("result : \(jsonData.value ?? "")")
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
