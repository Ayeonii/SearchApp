//
//  AppDetailData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import Foundation

struct AppDetailData {
    var headerData : AppDetailHeaderDataModel?
    var infoData : AppDetailInfoDataModel?
    var versionData : AppDetailVersionContentsDataModel?
    var screenShots : AppDetailScreenShotDataModel?
    var promotionData : AppDetailPromotionDataModel?


    init(_ res : SearchResultResponse) {
        
        if let result = res.results, result.count > 0  {
            let resultData = result[0]
            headerData = AppDetailHeaderDataModel(resultData)
            infoData = AppDetailInfoDataModel(resultData)
            versionData = AppDetailVersionContentsDataModel(resultData)
            screenShots = AppDetailScreenShotDataModel(resultData)
            promotionData = AppDetailPromotionDataModel(resultData)
        }
    }
}

struct AppDetailHeaderDataModel {
    var iconImage : String?
    var appName : String?
    var appDesc : String?
    
    init(_ data : SearchResults) {
        self.iconImage = data.artworkUrl60
        self.appName = data.trackName
        self.appDesc = data.sellerName
    }
}

struct AppDetailInfoDataModel {
    var detailInfo : [AppDetailInfoDataCellModel]?
  
    init(_ data : SearchResults) {
        var info : [AppDetailInfoDataCellModel] = []
        
        
        if let rating = data.averageUserRating, let count = data.userRatingCountForCurrentVersion {
            let ratingStr = "\(floor(rating))"
            let data = AppDetailInfoDataCellModel(title: "\(count.countNum())개의 평가", content: ratingStr, prefix: nil)
            info.append(data)
        }
            
        if let age = data.contentAdvisoryRating {
            let data = AppDetailInfoDataCellModel(title: "연령", content: age, prefix: "세")
            info.append(data)
        }
            
        if let developer = data.sellerName {
            let data = AppDetailInfoDataCellModel(title: "개발자", content: nil, prefix: developer)
            info.append(data)
        }
            
        if let lang = data.languageCodesISO2A {
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
            
            let data = AppDetailInfoDataCellModel(title: "언어", content: content, prefix: numberOfLang)
            info.append(data)
        }
        self.detailInfo = info
    }
    
}

struct AppDetailInfoDataCellModel {
    var title : String
    var content : String?
    var prefix : String?
    
    init(title : String, content : String?, prefix : String?) {
        self.title = title
        self.content = content
        self.prefix = prefix
    }
}

struct AppDetailVersionContentsDataModel {
    var version : String?
    var newDescription : String?
    var lastDate : String?
    
    init(_ data : SearchResults) {
        if let realeasNotes = data.releaseNotes {
            self.version = data.version
            self.newDescription = realeasNotes
            
            let realeaseDate = data.currentVersionReleaseDate
            self.lastDate = TimeCalculate().getPassedTime(realeaseDate)
        }
    }
}

struct AppDetailScreenShotDataModel {
    var screenShots : [String]?
    
    init(_ data : SearchResults){
        if let screenShotsArr = data.screenshotUrls {
            self.screenShots = screenShotsArr
        }
    }
}
    
struct AppDetailPromotionDataModel {
    var promotionData : [String]?
    
    init(_ data : SearchResults){
        if let promotionDesc = data.description {
            promotionData = promotionDesc
        }
    }
}
    
