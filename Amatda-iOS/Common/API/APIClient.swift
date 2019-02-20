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

struct CarrierInfo {
    static func setCarrierID(carrierID : Int){
        var carriers = myCarrierID()
        carriers.append(carrierID)
        UserDefaults.standard.setValue(carriers, forKey: "myCarriersID")
    }
    
    
    static func myCarrierID() -> [Int]{
        if let carrierID = UserDefaults.standard.object(forKey: "myCarriersID") as? [Int] {
            return carrierID
        }
        
        return []
    }
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
}
