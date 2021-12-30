//
//  DateFormatter+Extension.swift
//  PlanHub
//
//  Created by LuanLing on 9/17/21.
//

import Foundation

enum DateFormatHelper:String {
    case year = "yyyy"
    case fullMonth = "MMMM"
    case shortMonth = "MMM"
    case fullWeekday = "EEEE"
    case shortWeekday = "EEE"
    case day = "dd"
    case shortMonthDay = "MMM dd"
    case fullMonthDay = "MMMM dd"
    case fullMonthYear = "MMMM yyyy"
    case standard = "MMM dd, yyyy"
    case hourMinuteA = "hh:mm a"
    case twentyFourHourMinute = "HH:mm"
}

extension DateFormatter {
    static func initWithFormat(_ format: DateFormatHelper) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter
    }
}
