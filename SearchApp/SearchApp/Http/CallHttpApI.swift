//
//  CallHttpApi.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation

class CallHttpAPI {
    
    
    open class func callSearchApi(_ request :  SearchRequestParams, completion : @escaping ((_ result: SearchResultResponse?) -> Void)) {
        
        HttpManager.request("https://itunes.apple.com/search", "GET", encodable: request, responseClass: SearchResultResponse.self) { (result, error) in
        
            if let error = error {
                print(error)
                completion(nil)
            } else {
                if let result = result {
                    completion(result)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
