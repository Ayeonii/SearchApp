//
//  AppDetailData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import Foundation

struct AppDetailData {
    var iconImage : String
    var appName : String
    var appDesc : String
    var rating : Double?
    var commentRating : Int
    
    var screenShot : [String]
    
    init(){
        iconImage = ""
        appName = ""
        appDesc = ""
        rating = nil
        commentRating = 0
        
        screenShot = []
    }
}
