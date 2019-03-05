//
//  AMMainModel.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 21/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import RxDataSources


struct Carrier {
    let carrierID   : Int
    let startDate   : String
    let carrierName : String
    let carrierCountryID : Int
}

struct Package {
    let packageID : Int
    let carrierID : Int
    let packageName : String
    let packageColor : String
    let check : Bool
}


public let AMMainModelParseError = apiError("AMMainModel error during parsing")

struct CarrierModel{
    let carrier : Carrier?
    let options : [Int]?
    
    static func parseJSON(_ json : JSON) throws -> CarrierModel{
        guard let list = json["list"].dictionary,
              let carrierList = list["carrier"]?.arrayValue,
              let opt = list["opt"]?.arrayValue
        else {
            throw AMMainModelParseError
        }

        guard carrierList.count > 0 else { return CarrierModel(carrier: nil, options: nil) }
        let item = carrierList[0].dictionaryValue
        
        guard let id = item["cId"]?.intValue,
            let startDate = item["startDate"]?.stringValue,
            let carrierName = item["cName"]?.stringValue,
            let carrierCountryID = item["cCountry"]?.intValue
        else { throw AMMainModelParseError }
        
        
        let carrier = Carrier(carrierID: id,
                              startDate: startDate,
                              carrierName: carrierName,
                              carrierCountryID: carrierCountryID)
        
        
        let options : [Int] = opt.map{
            $0.dictionaryValue["oCategory"]?.intValue ?? 0
        }
        
        return CarrierModel(carrier: carrier, options: options)
    }
}


struct PackageModel{
    var unCheck : [Package]? = []
    var check   : [Package]? = []
    
    static func parseJSON(_ json : JSON) throws -> PackageModel{
        let data = json["package"].dictionaryValue
        
        guard let unCheckPack = data["uncheck"]?.arrayValue,
            let checkPack = data["check"]?.arrayValue
        else {
            throw AMMainModelParseError
        }
        
        let unPack = unCheckPack.map{
            Package(packageID: $0["pId"].intValue,
                    carrierID: $0["pcId"].intValue,
                    packageName: $0["pName"].stringValue,
                    packageColor: $0["pColor"].stringValue,
                    check: $0["pCheck"].boolValue)
        }
        
        let pack = checkPack.map{
            Package(packageID: $0["pId"].intValue,
                    carrierID: $0["pcId"].intValue,
                    packageName: $0["pName"].stringValue,
                    packageColor: $0["pColor"].stringValue,
                    check: $0["pCheck"].boolValue)
        }
        
        return PackageModel(unCheck: unPack, check: pack)
    }
}


struct SectionOfPackage{
    var header : String
    var items  : [Item]
}


extension SectionOfPackage: AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = Package
    
    var identity : String{
        return header
    }
    
    init(original: SectionOfPackage, items: [Item]) {
        self = original
        self.items = items
    }
}


extension Package : IdentifiableType, Equatable{
    typealias Identity = Int
    
    var identity: Int {
        return packageID
    }
    
    static func == (lhs: Package, rhs: Package) -> Bool {
        return lhs.packageID == rhs.packageID
            && lhs.packageName == rhs.packageName
    }
}
