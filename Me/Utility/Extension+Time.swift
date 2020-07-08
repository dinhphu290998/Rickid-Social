//
//  Extension+Time.swift
//  Me
//
//  Created by NDPhu on 7/8/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation

//TimeInterval
extension TimeInterval {
    var toDay: String {
        get {
            let date = Date(timeIntervalSince1970: self/1000)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/YYYY"
            return formatter.string(from: date)
        }
    }
    var toDate: String {
        get {
            let date = Date(timeIntervalSince1970: self/1000)
            let formatter = DateFormatter()
            formatter.dateFormat = "eeee"
            formatter.locale = Locale(identifier: "vi_VN")
            return formatter.string(from: date)
        }
    }
}

extension Date {
    func convertDateToTimeInterval() -> TimeInterval{
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .none
        dateformatter.dateFormat = "dd/MM/YYYY"
        let timeITV = TimeInterval(Int64(self.timeIntervalSince1970 * 1000))
        return timeITV
    }
}
