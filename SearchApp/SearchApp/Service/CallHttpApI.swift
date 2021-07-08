//
//  CallHttpApi.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation
import RxSwift

class CallHttpAPI {
    
    
    open class func callSearchApi(_ request :  SearchRequestParams) -> Observable<SearchResultResponse>  {
        
        return Observable.create { observer -> Disposable in
            let apiUrl = "https://itunes.apple.com/search"
            
            HttpAPIManager.call(api: apiUrl, method: .get, encodable: request, headers: HttpApiHeader.headers(), responseClass: SearchResultResponse.self) { (result, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    if let res = result{
                        observer.onNext(res)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
}
