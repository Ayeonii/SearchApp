//
//  SearchMainViewModel.swift
//  SearchApp
//
//  Created by 이아연 on 2021/07/08.
//

import Foundation
import RxSwift

class SearchMainViewModel {
    var searchListDataSubject = BehaviorSubject<[String]>(value: [])
    var inputText : String?
   
    init() {
        setRecentData()
    }
    
}

extension SearchMainViewModel {
    func setRecentData() {
        searchListDataSubject.onNext(StoredData.shared.getRecentSearchData() ?? [])
    }
    
    func setSearchListData(inputText : String) {
        let filteredList = StoredData.shared.getRecentSearchData()?.filter{
            $0.hasPrefix(inputText)
        }
        
        searchListDataSubject.onNext(filteredList ?? [])
    }
    
    func saveRecentSearchData( _ txt : String) {
        
        var recentList : [String] = []
  
        if let recentData = StoredData.shared.getRecentSearchData() {
            var uniqueList = recentData.filter {$0 != txt}
            uniqueList.append(txt)
            recentList = uniqueList
        } else {
            recentList.append(txt)
        }
        
        StoredData.shared.setRecentSearchData(param: recentList)
    }
    
    func isSearchingActivate(_ searchController : UISearchController?) -> Bool {
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false

        return isActive && isSearchBarHasText
    }

}
