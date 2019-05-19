//
//  Carrier.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 12/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct Carrier {
    let startDate   : String
    let carrierName : String
    let countryName : String
    let carrierID   : Int
    var packages    : [Package]
    
    init(startDate: String,
         carrierName: String = "캐리어",
         countryName: String,
         carrierOption : [Int]? = nil,
         packages   : [Package] = [Package](),
         carrierID  : Int = Int(round(Date().timeIntervalSince1970 * 1000))
        ){
        self.startDate = startDate
        self.carrierName = carrierName
        self.countryName = countryName
        self.carrierID   = carrierID
        self.packages = packages
        
        if let options = carrierOption {
            self.packages.append(contentsOf: getRecommandPackages(carrierOption: options))
        }
    }
}



extension Carrier{
    private func getRecommandPackages(carrierOption: [Int])->[Package]{
        var packages = [Package]()
        for option in carrierOption {
            switch option {
            case 1:
                packages.append(self.makeDefaultPackage(name: "여권",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "상비약",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "콘센트 어댑터",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "속옷",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "지갑",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "양말",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "세면도구",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "핸드폰 충전기",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "보조배터리",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "썬크림",
                                                        packageID: self.packages.count + packages.count))
                break
                
            case 2:
                packages.append(self.makeDefaultPackage(name: "수영복",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "수모",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "수경",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "비치타올",
                                                        packageID: self.packages.count + packages.count))
                break
                
            case 3:
                packages.append(self.makeDefaultPackage(name: "고글",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "모자",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "장갑",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "스키복",
                                                        packageID: self.packages.count + packages.count))
                break
                
            case 4:
                packages.append(self.makeDefaultPackage(name: "텐트",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "돗자리",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "릴선",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "의자",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "테이블",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "코펠",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "멀티탭",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "랜턴",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "토치",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "버너",
                                                        packageID: self.packages.count + packages.count))
                break
                
            case 5:
                packages.append(self.makeDefaultPackage(name: "명함",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "노트북",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "노트북 충전기",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "마우스",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "USB",
                                                        packageID: self.packages.count + packages.count))
                break
                
            case 6:
                packages.append(self.makeDefaultPackage(name: "이유식",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "분유",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "젖병",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "노리개 젖꼭지",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "기저귀",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "물티슈",
                                                        packageID: self.packages.count + packages.count))
                packages.append(self.makeDefaultPackage(name: "아기용 생수",
                                                        packageID: self.packages.count + packages.count))
                break
                
            default:
                break
            }
        }
        
        return packages
    }
    
    
    private func makeDefaultPackage(name:String,
                                    packageID:Int) -> Package{
        return Package(carrierID: self.carrierID,
                       packageID: packageID,
                       packageName: name,
                       packageColor: "labelDefault",
                       check: false)
    }
}
