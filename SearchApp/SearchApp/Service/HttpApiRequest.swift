//
//  HttpAPIManager.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation

struct SearchRequestParams: Encodable {
    
    var term : String?
    var entity : String?
    var country : String?
    var id : Int?

    init(searchTerm : String, entity : String? = "software", country : String? = "KR", id : Int? = nil) {
        self.term = searchTerm
        self.entity = entity
        self.country = country ?? "KR"
        self.id = id
    }
}

struct SearchAnAppRequestParams: Encodable {
    var id : Int
    var entity : String = "software"
    var country : String?
    
    init(id : Int, entity : String? = "software", country : String? = "KR") {
        self.id = id
        self.entity = entity!
        self.country = country!
    }
}
