//
//  SearchTableData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation

struct AppListData {
    var data : [AppListDataCellModel]?
    
    init(_ response :  SearchResultResponse){
        var appData : [AppListDataCellModel] = []
        
        if let res = response.results {
            appData = res.map {
                AppListDataCellModel($0)
            }
        }
        self.data = appData
    }
}

struct AppListDataCellModel {
    var iconImage : String
    var appName : String
    var appDesc : String
    var rating : Double?
    var commentRating : Int
    var appId : Int?
    
    var screenShot1 : String?
    var screenShot2 : String?
    var screenShot3 : String?
    
    init(_ data : SearchResults) {
        
        self.iconImage = data.artworkUrl60 ?? ""
        self.appName = data.trackName ?? ""
        self.appDesc = ""
        self.appId = data.trackId
            
        self.rating = data.averageUserRating ?? 0.0
        self.commentRating = data.userRatingCountForCurrentVersion ?? 0
            
        if let urls = data.screenshotUrls, urls.count > 0 {
            self.screenShot1 = urls.count >= 1 ? urls[0] : nil
            self.screenShot2 = urls.count >= 2 ? urls[1] : nil
            self.screenShot3 = urls.count >= 3 ? urls[2] : nil
        }
    }
}


