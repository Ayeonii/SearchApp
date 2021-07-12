//
//  AppDetailViewModel.swift
//  SearchApp
//
//  Created by 이아연 on 2021/07/12.
//

import Foundation
import RxSwift
import RxDataSources

class AppDetailViewModel {
    private var disposeBag = DisposeBag()
    
    let dataSource = AppDetailDataSource.dataSource()
    var appInfoSubject = BehaviorSubject<[AppDetailSectionModel]>(value: [])
    
    init(appName : String){
        callAppDetailInfo(appName)
    }
}

extension AppDetailViewModel {
    
    func callAppDetailInfo(_ appName : String) {
        
        let req = SearchRequestParams(searchTerm: appName)
        CallHttpAPI.callSearchApi(req)
            .subscribe(onNext: { [weak self] res in
                self?.emitEvent(res: res)
            }, onError: { error in
                debugPrint(error)
            }, onCompleted: {
                debugPrint("Completed!")
            })
            .disposed(by: disposeBag)
    }
    
    func emitEvent(res : SearchResultResponse) {
        var tmpCells : [AppDetailSectionModel] = []
        
        if let data = res.results, data.count > 0 {
            tmpCells.append(AppDetailSectionModel.HeaderSection(content : [
                .Header(AppDetailHeaderDataModel(data[0]))
            ]))
            tmpCells.append(AppDetailSectionModel.DetailInfoSection(content : [
                .DetailInfo(AppDetailInfoDataModel(data[0]))
            ]))
            tmpCells.append(AppDetailSectionModel.VersionInfoSection(content : [
                .VersionInfo(AppDetailVersionContentsDataModel(data[0]))
            ]))
            tmpCells.append(AppDetailSectionModel.ScreenShotInfoSection(content : [
                .ScreenShotInfo(AppDetailScreenShotDataModel(data[0]))
            ]))
            tmpCells.append(AppDetailSectionModel.PromotionInfoSection(content : [
                .PromotionInfo(AppDetailPromotionDataModel(data[0]))
            ]))
        }
        
        appInfoSubject.onNext(tmpCells)
    }
}
