//
//  TimeCalculate.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/24.
//

import Foundation

class TimeCalculate {
    
    lazy var getPassedTime : ((_ date : String?) -> String) = { (date) in
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        format.locale = Locale(identifier: "ko")
        
        let date = format.date(from: date ?? "1900-12-31'T'00:00:00Z")!
        format.dateFormat = "MM-dd-yyyy"
        let cretTime = format.string(from: date)

        let currTime = format.string(from: Date()) //현재시간
        
        let startTime = format.date(from: cretTime)
        let endTime = format.date(from: currTime )

        let startDay = Calendar.current.dateComponents([.year, .month, .day], from: startTime!)
        let endDay = Calendar.current.dateComponents([.year, .month, .day], from: endTime!)
        
        var diff : String
        
        if startDay.year == endDay.year {
            if startDay.month == endDay.month {
                if startDay.day == endDay.day {
                    let diffTime = Int(endTime!.timeIntervalSince(startTime!))
                    if diffTime > 60 {
                        diff = "\(diffTime/60)분"
                    } else {
                        diff = "방금"
                    }
                } else {
                    let diffDay = endDay.day! - startDay.day!
                    if diffDay >= 7 {
                        diff = "\(diffDay/7)주"
                    } else {
                        diff = "\(diffDay)일"
                    }
                }
            } else {
                let diffMon = endDay.month! - startDay.month!
                diff = "\(diffMon)달"
            }
        } else {
            let diffYear = endDay.year! - startDay.year!
            var diffMon = endDay.month! - startDay.month!
            if diffYear == 1 , diffMon < 0 {
                diffMon = 12 - (startDay.month! - endDay.month!)
                diff = "\(diffMon)달"
            } else {
                diff = "\(diffYear)년"
            }
        }
        return diff
    }
}
