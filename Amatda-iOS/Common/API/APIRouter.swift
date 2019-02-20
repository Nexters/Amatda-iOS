//
//  APIRouter.swift
//  Amatda-iOS
//
//  Created by JHH on 19/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

/*
 1. 캐리어 상세정보 보기 ( 특정 캐리어 아이디에 대한 캐리어 상세정보 )
 http method : get
 url -> /carrier/list?cId = 2 ( 파라미터 : cId - 캐리어 아이디)
 
 2. 캐리어 등록하기
 http method : post
 body에 들어갈 데이터 : cCountry(varchar), category_list( array )
 url - > /carrier/insert
 return 값 : cId ( 캐리어 아이디 )
 
 3. 캐리어 삭제하기
 http method : delete
 url -> /carrier/delete?cId = 2 ( 파라미터 : cId - 캐리어 아이디 )
 
 4. 준비물 상세정보 보기 ( 특정 준비물 아이디에 대한 준비물 상세정보 )
 http method : get
 url -> /pack/list?pId=2 ( 파라미터 : pId - 준비물 아이디 )
 
 5. 특정 캐리어에 대한 모든 준비물 출력 ( = 특정 캐리어에 포함되어있는 모든 준비믈 출력)
 http method : get
 url -> /pack/listall?cId = 2 ( 파라미터 : cId - 캐리어 아이디 )
 
 6. 준비물 등록하기
 http method : post
 body에 넣을 데이터 : pcId(int), pName(varchar), pColor(varchar), pCheck(varchar)
 url -> /pack/insert
 return 값 : pId ( 준비물 아이디 )
 
 7. 준비물 삭제하기
 http method : delete
 url -> /pack/delete?pId = 2 ( 파라미터 : pId - 준비물 아이디 )
 
 8. 준비물 체크하기.
 http method : post
 body에 넣을 데이터 : pId(int), pCheck(varchar)
 url -> /pack/update
 
 9. 추천 준비물 조회하기.
 -> 서버에서 이 데이터를 먼저 해당 캐리어에 넣은 후 select 해서 Client에게 던져준다.
 http method : get
 url -> /checklist/recommend?cId=2( 파라미터 : cId - 캐리어 아이디)
 
 10. 날씨 조회하기.
 http method : get
 url -> /weather/list?city_id=2&month=12 ( 파라미터 : city_id - 도시 id, month - 월)
 
 추가 개발 계획)
 */
import Foundation
import Alamofire


enum APIRouter : URLRequestConvertible {
    //캐리어 상세정보 보기
    case detailCarrier(carrierID : Int)
    
    //캐리어 등록하기
    case registerCarrier(countryID : Int, startDate : String ,options : [Int])
    
    //캐리어 삭제하기
    case deleteCarrier(carrierID : Int)
    
    //특정 캐리어에 대한 모든 준비물 출력 sort : (0 등록순, 1 라벨순)
    case packageList(carrierID : Int, sort: Int)
    
    //준비물 등록하기
    case registerPackage(carrierID : Int,
        packageName:String,
        labelColor : String,
        check : String)
    
    //준비물 삭제하기
    case deletePackage(packageID : Int)
    
    //준비물 체크하기
    case checkPackage(packageID : Int, check : String)
    
    //날씨 조회하기
    case weatherOfCity(cityID : Int, month : Int)

    
    func asURLRequest() throws -> URLRequest {
        let url = self.url
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = self.method.rawValue
        if let parameter = self.parameter {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    
    private var url : URL {
        switch self {
        default:
            return URL(string: "http://amatda.kro.kr:8080/nexters_project")!
        }
    }
    
    
    private var method: HTTPMethod{
        switch self {
        case .detailCarrier(_),
             .packageList(_,_),
             .weatherOfCity(_):
            return .get
            
        case .registerCarrier(_,_,_),
             .registerPackage(_,_,_,_),
             .checkPackage(_, _):
            return .post
            
        case .deleteCarrier(_),
             .deletePackage(_):
            return .delete
        }
    }
    
    
    private var path : String{
        switch self {
        case .detailCarrier(let carrierID):
            return "/carrier/list?cId=\(carrierID)"
        case .packageList(let carrierID, let sort):
            return "/pack/all?cId=\(carrierID)&sort=\(sort)"
        case .weatherOfCity(let cityID, let month):
            return "/weather/list?city_id=\(cityID)&month=\(month)"
        case .registerPackage(_,_,_,_):
            return "/pack/insert"
        case .registerCarrier(_,_,_):
            return "/carrier"
        case .checkPackage(_, _):
            return "/pack/update"
        case .deleteCarrier(let carrierID):
            return "/carrier/delete?cId=\(carrierID)"
        case .deletePackage(let packageID):
            return "/pack/delete?pId = \(packageID)"
        }
    }
    
    
    private var parameter : Parameters?{
        var param : Parameters = [:]
        
        switch self {
        case .registerCarrier(let countryID ,let startTime, let options):
            param["cName"]         = "캐리어 1"
            param["cCountry"]      = countryID
            param["startDate"]     = startTime //"YY-MM-DD hh:mm:ss"
            options.map{
                param["category_list"] = $0
            }
            break
            
        case .registerPackage(let carrierID, let packageName, let labelColor, let check):
            param["pcId"]   = carrierID
            param["pName"]  = packageName
            param["pColor"] = labelColor
            param["pCheck"] = check
            break
            
        case .checkPackage(let packageID, let check):
            param["pId"]    = packageID
            param["pCheck"] = check
            break
            
        default:
            break
        }
        
        return param
    }
}
