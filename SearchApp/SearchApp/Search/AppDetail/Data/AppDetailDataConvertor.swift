//
//  AppDetailDataConvertor.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import Foundation

class AppDetailConvertor {
    var data : SearchResultResponse
    
    init(_ contentsData : SearchResultResponse) {
        self.data = contentsData
    }
        
    func getAppDetailData() -> AppDetailData {
        var appDetailData : [AppDetailData] = []
        
        if let result = data.results, result.count > 0  {
            var headerData = AppDetailHeaderData()
            
            headerData.iconImage = result[0].artworkUrl60
            
        }
        return appDetailData[0]
            
    }
    
}
