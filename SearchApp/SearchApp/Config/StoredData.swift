//
//  SearchSingleton.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import Foundation

class StoredData {
    
    static let shared = StoredData()
    private init(){}
    private let RECENT_KEY = "recentSearch"
    
    var recentSearchData : [String]?
    
    //최근검색데이터 - 50개 갯수 제한 (필요 시, 삭제)
    func setRecentSearchData(param : [String]?) {
        
        var list = param
        
        if let _ = list {
            while list!.count > 50 {
                list!.removeFirst()
            }
            
            self.recentSearchData = list!
            save(id : RECENT_KEY)
        } else {
            self.recentSearchData = nil
            save(id : RECENT_KEY)
        }
    }
    
    func getRecentSearchData() -> [String]? {
        self.recentSearchData = UserDefaults.standard.array(forKey: RECENT_KEY) as? [String]
        return self.recentSearchData
    }
    
    func save(id : String) {
        UserDefaults.standard.set(recentSearchData, forKey: id)
        UserDefaults.standard.synchronize()
    }
}
