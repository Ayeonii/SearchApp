//
//  SearchTableData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation

struct AppListData {
    var iconImage : String
    var appName : String
    var appDesc : String
    var rating : Double?
    var commentRating : Int
    
    var screenShot1 : String?
    var screenShot2 : String?
    var screenShot3 : String?
    
    init(){
        iconImage = ""
        appName = ""
        appDesc = ""
        rating = nil
        commentRating = 0
        
        screenShot1 = nil
        screenShot2 = nil
        screenShot3 = nil
    }

}


class AppListDataConvertor {
    var data : SearchResultResponse
    
    init(_ contentsData : SearchResultResponse) {
        self.data = contentsData
    }
        
    func getAppListData() -> [AppListData] {
        var appData : [AppListData] = []
        
        if let result = data.results {
            appData = result.map {
                var oneData = AppListData()
                oneData.iconImage = $0.artworkUrl60 ?? ""
                oneData.appName = $0.trackName ?? ""
                oneData.appDesc = ""
                oneData.rating = $0.averageUserRating ?? 0.0
                oneData.commentRating = $0.userRatingCount ?? 0
                
                if let urls = $0.screenshotUrls, urls.count > 0 {
                    oneData.screenShot1 = urls.count >= 1 ? urls[0] : nil
                    oneData.screenShot2 = urls.count >= 2 ? urls[1] : nil
                    oneData.screenShot3 = urls.count >= 3 ? urls[2] : nil
                }
                
                return oneData
            }
        }
        return appData
    }
}
