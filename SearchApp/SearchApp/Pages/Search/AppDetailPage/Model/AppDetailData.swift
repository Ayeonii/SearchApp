//
//  AppDetailData.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import Foundation
import RxSwift
import RxDataSources


struct AppDetailHeaderDataModel {
    var iconImage : String?
    var appName : String?
    var appDesc : String?
    
    init(_ data : SearchResults) {
        self.iconImage = data.artworkUrl60
        self.appName = data.trackName
        self.appDesc = data.sellerName
    }
}

struct AppDetailInfoDataModel {
    var detailInfo : [AppDetailInfoDataCellModel]?
    
    init(_ data : SearchResults) {
        var info : [AppDetailInfoDataCellModel] = []
        
        
        if let rating = data.averageUserRating, let count = data.userRatingCountForCurrentVersion {
            let ratingStr = "\(floor(rating))"
            let data = AppDetailInfoDataCellModel(title: "\(count.countNum())개의 평가", content: ratingStr, prefix: nil)
            info.append(data)
        }
        
        if let age = data.contentAdvisoryRating {
            let data = AppDetailInfoDataCellModel(title: "연령", content: age, prefix: "세")
            info.append(data)
        }
        
        if let developer = data.sellerName {
            let data = AppDetailInfoDataCellModel(title: "개발자", content: nil, prefix: developer)
            info.append(data)
        }
        
        if let lang = data.languageCodesISO2A {
            var numberOfLang : String?
            let content : String
            
            if lang.contains("KO") {
                content = "KO"
            } else {
                content = lang[0]
            }
            
            if lang.count > 1 {
                numberOfLang = "+ \(lang.count)개의 언어"
            }
            
            let data = AppDetailInfoDataCellModel(title: "언어", content: content, prefix: numberOfLang)
            info.append(data)
        }
        self.detailInfo = info
    }
    
}

struct AppDetailInfoDataCellModel {
    var title : String
    var content : String?
    var prefix : String?
    
    init(title : String, content : String?, prefix : String?) {
        self.title = title
        self.content = content
        self.prefix = prefix
    }
}

struct AppDetailVersionContentsDataModel {
    var version : String?
    var newDescription : String?
    var lastDate : String?
    
    init(_ data : SearchResults) {
        if let realeasNotes = data.releaseNotes {
            self.version = data.version
            self.newDescription = realeasNotes
            
            let realeaseDate = data.currentVersionReleaseDate
            self.lastDate = TimeCalculate().getPassedTime(realeaseDate)
        }
    }
}

struct AppDetailScreenShotDataModel {
    var screenShots : [String]?
    
    init(_ data : SearchResults){
        if let screenShotsArr = data.screenshotUrls {
            self.screenShots = screenShotsArr
        }
    }
}

struct AppDetailPromotionDataModel {
    var promotionData : String?
    
    init(_ data : SearchResults){
        if let promotionDesc = data.description {
            promotionData = promotionDesc
        }
    }
}

// MARK: - Make DataSources
enum AppDetailSectionItem {
    case Header(AppDetailHeaderDataModel)
    case DetailInfo(AppDetailInfoDataModel)
    case VersionInfo(AppDetailVersionContentsDataModel)
    case ScreenShotInfo(AppDetailScreenShotDataModel)
    case PromotionInfo(AppDetailPromotionDataModel)
}

enum AppDetailSectionModel {
    case HeaderSection(content : [AppDetailSectionItem])
    case DetailInfoSection(content : [AppDetailSectionItem])
    case VersionInfoSection(content : [AppDetailSectionItem])
    case ScreenShotInfoSection(content : [AppDetailSectionItem])
    case PromotionInfoSection(content : [AppDetailSectionItem])
}

extension AppDetailSectionModel : SectionModelType {
    typealias Item = AppDetailSectionItem
    
    var items : [Item] {
        switch self {
        case let .HeaderSection(content) :
            return content
        case let .DetailInfoSection(content) :
            return content
        case let .VersionInfoSection(content) :
            return content
        case let .ScreenShotInfoSection(content) :
            return content
        case let .PromotionInfoSection(content) :
            return content
        }
    }
    
    
    init(original: AppDetailSectionModel, items: [AppDetailSectionItem]) {
        self = original
    }
}

struct AppDetailDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<AppDetailSectionModel> {
        return .init(configureCell: { dataSource, tableView, indexPath, sectionItem -> UITableViewCell in
            switch dataSource[indexPath] {
            case .Header(let header) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailHeaderTableViewCell", for: indexPath) as! AppDetailHeaderTableViewCell
                cell.model = header
                cell.selectionStyle = .none
                return cell
            case .DetailInfo(let detailInfo) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoTableViewCell", for: indexPath) as! AppDetailInfoTableViewCell
                cell.model = detailInfo
                cell.selectionStyle = .none
                return cell
            case .VersionInfo(let version) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailVersionContentsTableViewCell", for: indexPath) as! AppDetailVersionContentsTableViewCell
                cell.model = version
                cell.selectionStyle = .none
                return cell
            case .ScreenShotInfo(let screenshot) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailScreenShotTableViewCell", for: indexPath) as! AppDetailScreenShotTableViewCell
                cell.model = screenshot
                cell.selectionStyle = .none
                return cell
            case .PromotionInfo(let desc) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailPromotionTableViewCell", for: indexPath) as! AppDetailPromotionTableViewCell
                cell.model = desc
                cell.selectionStyle = .none
                return cell
            }
        })
    }
}
