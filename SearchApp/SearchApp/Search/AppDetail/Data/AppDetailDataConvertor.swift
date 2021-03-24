//
//  AppDetailDataConvertor.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import Foundation


class AppDetailConvertor {
    /*
    var data : SearchResultResponse

    init(_ contentsData : SearchResultResponse) {
        self.data = contentsData
    }
        
    func getAppDetailData() -> AppDetailData {
        var appDetailData = AppDetailData()
        
        if let result = data.results, result.count > 0  {
            let resultData = result[0]
            
            var headerData = AppDetailHeaderData()
            var detailInfoData : [AppDetailInfoData] = []
            var versionData : AppDetailVersionContentsData?
            var screenShotData : [String]?
            var promotionData : String?
            
            //헤더데이터
            headerData.iconImage = resultData.artworkUrl60
            headerData.appName = resultData.trackName
            headerData.appDesc = resultData.sellerName
            
            //정보데이터
            if let rating = resultData.averageUserRating, let count = resultData.userRatingCountForCurrentVersion {
                let ratingStr = "\(floor(rating))"
                let data = AppDetailInfoData(title: "\(count.countNum())개의 평가", content: ratingStr, prefix: nil)
                detailInfoData.append(data)
            }
            
            if let age = resultData.contentAdvisoryRating {
                let data = AppDetailInfoData(title: "연령", content: age, prefix: "세")
                detailInfoData.append(data)
            }
            
            if let developer = resultData.sellerName {
                let data = AppDetailInfoData(title: "개발자", content: nil, prefix: developer)
                detailInfoData.append(data)
            }
            
            if let lang = resultData.languageCodesISO2A {
                var numberOfLang : String?
                let content : String
                
                if lang.contains("KO") {
                    content = "KO"
                } else {
                    content = lang[0]
                }
                
                if lang.count > 1 {
                    numberOfLang = "+ \(lang.count)개의 언어"
                }
            
                let data = AppDetailInfoData(title: "언어", content: content, prefix: numberOfLang)
                detailInfoData.append(data)
            }
            
            //버전 데이터
            if let realeasNotes = resultData.releaseNotes {
                let version = resultData.version ?? ""
                let realeaseDate = resultData.currentVersionReleaseDate
                let date = TimeCalculate().getPassedTime(realeaseDate)
                versionData = AppDetailVersionContentsData(version: version, newDescription: realeasNotes, lastDate: date)
            }
        
            //스크린샷
            if let screenShots = resultData.screenshotUrls {
                screenShotData = screenShots
            }
            
            //프로모션텍스트 데이터
            if let promotionDesc = resultData.description {
                promotionData = promotionDesc
            }

            appDetailData.headerData = headerData
            appDetailData.infoData = detailInfoData
            appDetailData.versionData = versionData
            appDetailData.screenShots = screenShotData ?? []
            appDetailData.promotionData = promotionData ?? ""
        }
        
        return appDetailData
            
    }*/
    
}
