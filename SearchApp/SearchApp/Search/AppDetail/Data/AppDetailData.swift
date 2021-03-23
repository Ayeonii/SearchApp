//
//  AppDetailData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import Foundation

struct AppDetailData {
    var headerData : AppDetailHeaderData?
    var infoData : AppDetailInfoData?
    var versionData : AppDetailVersionContentsData?
    var promotionData : AppDetailPromotionData?
    var reviewData : [AppDetailReviewData]?
}

struct AppDetailHeaderData {
    var iconImage : String?
    var appName : String?
    var appDesc : String?
    
}

struct AppDetailInfoData {
    var title : String
    var content : String
    var prefix : String
}

struct AppDetailVersionContentsData {
    var version : String
    var newDescription : String
    var lastDate : String
}

struct AppDetailPromotionData {
    var descriptionLabel : String
    var lastLabel : String
}

struct AppDetailReviewData {
    var rating : Double
    var userReviewCount : Int
}
