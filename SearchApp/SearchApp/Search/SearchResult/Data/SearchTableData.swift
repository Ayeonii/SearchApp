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
    var appId : Int?
    
    var screenShot1 : String?
    var screenShot2 : String?
    var screenShot3 : String?
    
    init(){
        iconImage = ""
        appName = ""
        appDesc = ""
        rating = nil
        commentRating = 0
        appId = nil
        
        screenShot1 = nil
        screenShot2 = nil
        screenShot3 = nil
    }

}


