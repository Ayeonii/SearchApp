//
//  HttpRequestData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation

struct SearchRequestParams: Encodable {
    
    var term : String? = ""
    var entity : String? = "software"
    var country : String?
    
    init(searchTerm : String, entity : String, country : String? = "KR") {
        self.term = searchTerm
        self.entity = entity
        self.country = country ?? "KR"
    }
}
