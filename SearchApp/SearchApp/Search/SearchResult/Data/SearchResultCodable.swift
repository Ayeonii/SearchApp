//
//  SearchResultCodable.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation
struct SearchResultResponse : Codable {
    let resultCount : Int?
    let results : [SearchResults]?

    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([SearchResults].self, forKey: .results)
    }
}

struct SearchResults : Codable {
    let screenshotUrls : [String]?
    let ipadScreenshotUrls : [String]?
    let appletvScreenshotUrls : [String]?
    let artworkUrl60 : String?
    let artworkUrl512 : String?
    let artworkUrl100 : String?
    let artistViewUrl : String?
    let supportedDevices : [String]?
    let advisories : [String]?
    let isGameCenterEnabled : Bool?
    let features : [String]?
    let kind : String?
    let minimumOsVersion : String?
    let trackCensoredName : String?
    let languageCodesISO2A : [String]?
    let fileSizeBytes : String?
    let sellerUrl : String?
    let formattedPrice : String?
    let contentAdvisoryRating : String?
    let averageUserRatingForCurrentVersion : Double?
    let userRatingCountForCurrentVersion : Int?
    let averageUserRating : Double?
    let trackViewUrl : String?
    let trackContentRating : String?
    let trackId : Int?
    let trackName : String?
    let releaseDate : String?
    let sellerName : String?
    let primaryGenreName : String?
    let genreIds : [String]?
    let isVppDeviceBasedLicensingEnabled : Bool?
    let currentVersionReleaseDate : String?
    let releaseNotes : String?
    let primaryGenreId : Int?
    let currency : String?
    let description : String?
    let artistId : Int?
    let artistName : String?
    let genres : [String]?
    let price : Double?
    let bundleId : String?
    let version : String?
    let wrapperType : String?
    let userRatingCount : Int?

    enum CodingKeys: String, CodingKey {

        case screenshotUrls = "screenshotUrls"
        case ipadScreenshotUrls = "ipadScreenshotUrls"
        case appletvScreenshotUrls = "appletvScreenshotUrls"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl512 = "artworkUrl512"
        case artworkUrl100 = "artworkUrl100"
        case artistViewUrl = "artistViewUrl"
        case supportedDevices = "supportedDevices"
        case advisories = "advisories"
        case isGameCenterEnabled = "isGameCenterEnabled"
        case features = "features"
        case kind = "kind"
        case minimumOsVersion = "minimumOsVersion"
        case trackCensoredName = "trackCensoredName"
        case languageCodesISO2A = "languageCodesISO2A"
        case fileSizeBytes = "fileSizeBytes"
        case sellerUrl = "sellerUrl"
        case formattedPrice = "formattedPrice"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case averageUserRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
        case averageUserRating = "averageUserRating"
        case trackViewUrl = "trackViewUrl"
        case trackContentRating = "trackContentRating"
        case trackId = "trackId"
        case trackName = "trackName"
        case releaseDate = "releaseDate"
        case sellerName = "sellerName"
        case primaryGenreName = "primaryGenreName"
        case genreIds = "genreIds"
        case isVppDeviceBasedLicensingEnabled = "isVppDeviceBasedLicensingEnabled"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
        case releaseNotes = "releaseNotes"
        case primaryGenreId = "primaryGenreId"
        case currency = "currency"
        case description = "description"
        case artistId = "artistId"
        case artistName = "artistName"
        case genres = "genres"
        case price = "price"
        case bundleId = "bundleId"
        case version = "version"
        case wrapperType = "wrapperType"
        case userRatingCount = "userRatingCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        screenshotUrls = try values.decodeIfPresent([String].self, forKey: .screenshotUrls)
        ipadScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .ipadScreenshotUrls)
        appletvScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .appletvScreenshotUrls)
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
        artworkUrl512 = try values.decodeIfPresent(String.self, forKey: .artworkUrl512)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
        supportedDevices = try values.decodeIfPresent([String].self, forKey: .supportedDevices)
        advisories = try values.decodeIfPresent([String].self, forKey: .advisories)
        isGameCenterEnabled = try values.decodeIfPresent(Bool.self, forKey: .isGameCenterEnabled)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        minimumOsVersion = try values.decodeIfPresent(String.self, forKey: .minimumOsVersion)
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
        languageCodesISO2A = try values.decodeIfPresent([String].self, forKey: .languageCodesISO2A)
        fileSizeBytes = try values.decodeIfPresent(String.self, forKey: .fileSizeBytes)
        sellerUrl = try values.decodeIfPresent(String.self, forKey: .sellerUrl)
        formattedPrice = try values.decodeIfPresent(String.self, forKey: .formattedPrice)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        averageUserRatingForCurrentVersion = try values.decodeIfPresent(Double.self, forKey: .averageUserRatingForCurrentVersion)
        userRatingCountForCurrentVersion = try values.decodeIfPresent(Int.self, forKey: .userRatingCountForCurrentVersion)
        averageUserRating = try values.decodeIfPresent(Double.self, forKey: .averageUserRating)
        trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
        trackContentRating = try values.decodeIfPresent(String.self, forKey: .trackContentRating)
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        sellerName = try values.decodeIfPresent(String.self, forKey: .sellerName)
        primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
        genreIds = try values.decodeIfPresent([String].self, forKey: .genreIds)
        isVppDeviceBasedLicensingEnabled = try values.decodeIfPresent(Bool.self, forKey: .isVppDeviceBasedLicensingEnabled)
        currentVersionReleaseDate = try values.decodeIfPresent(String.self, forKey: .currentVersionReleaseDate)
        releaseNotes = try values.decodeIfPresent(String.self, forKey: .releaseNotes)
        primaryGenreId = try values.decodeIfPresent(Int.self, forKey: .primaryGenreId)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        genres = try values.decodeIfPresent([String].self, forKey: .genres)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        bundleId = try values.decodeIfPresent(String.self, forKey: .bundleId)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
        userRatingCount = try values.decodeIfPresent(Int.self, forKey: .userRatingCount)
    }

}
