//
//  SearchResultViewModel.swift
//  SearchApp
//
//  Created by 이아연 on 2021/07/08.
//

import RxSwift

class SearchResultViewModel {
    var disposeBag = DisposeBag()
    var searchResultSubject = PublishSubject<[AppListDataCellModel]>()
    
    init(searchWord : String){
        self.callSearchApi(searchWord)
    }
}

extension SearchResultViewModel {
    
    func callSearchApi(_ searchWord : String) {
        let req = SearchRequestParams(searchTerm: searchWord, entity: "software")
        CallHttpAPI.callSearchApi(req)
            .subscribe(onNext: {[weak self] res in
                let listData = AppListData(res).data ?? []
                self?.searchResultSubject.onNext(listData)
            }, onError: { error in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
    }
}
