//
//  Date+Extension.swift
//  PlanHub
//
//  Created by LuanLing on 9/17/21.
//

import Foundation

extension Date {
    static func getHourMinute(_ date:Date?) -> String {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.hourMinuteA)
        let timeStr = fmt.string(from: date)
        return timeStr
    }
    
    static func getTwentyFourHourMinute(_ date:Date?) -> String {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.twentyFourHourMinute)
        let timeStr = fmt.string(from: date)
        return timeStr
    }
    
    static func getMonthStringByDate(_ date:Date?, _ format:DateFormatHelper = .fullMonth) -> String  {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(format)
        let month = fmt.string(from: date)
        return month
    }
    
    static func getMonthIntByDate(_ date:Date = Date()) -> Int {
        let month = Calendar.current.component(.month, from: date)
        return month
    }
    
    static func getMonthDayStringByDate(_ date:Date?, _ shortFormat:Bool = false) -> String  {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(shortFormat ? .shortMonthDay : .fullMonthDay)
        let month = fmt.string(from: date)
        return month
    }
    
    static func getMonthIndexByMonthString(_ month:String) -> Int {
        let monthSymbols:[String] = Calendar.current.monthSymbols
        var mInt = 1
        for (i, m) in monthSymbols.enumerated() {
            if month == m {
                mInt = i + 1
            }
        }
        return mInt
    }
    
    static func getWeekdayOfFirstdayInMonth(_ year:Int, _ month:Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month

        let calendar = Calendar.current
        if let fDay = calendar.date(from: dateComponents) {
            let weekDay = calendar.dateComponents([.weekday], from: fDay).weekday
            return weekDay ?? 0
        }
        return 0
    }
    
    static func getNumberOfDaysInMonth(_ year:Int, _ month:Int) -> Int{
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month

        let calendar = Calendar.current
        let fDay = calendar.date(from: dateComponents)
        if let firstDay = fDay {
            if let interval = calendar.dateInterval(of: .month, for: firstDay) {
                let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
                return days
            }
        }
        return 30
    }
    
    static func getYearStringByDate(_ date:Date?) -> String  {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.year)
        let month = fmt.string(from: date)
        return month
    }
    
    static func getYearIntByDate(_ date:Date = Date()) -> Int {
        let year = Calendar.current.component(.year, from: date)
        return year
    }
    
    static func getDayStringByDate(_ date:Date?) -> String  {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.day)
        let day = fmt.string(from: date)
        return day
    }
    
    static func getDayIntByDate(_ date:Date = Date()) -> Int {
        let day = Calendar.current.component(.day, from: date)
        return day
    }
    
    static func getShortWeekdayStringByDate(_ date:Date?) -> String  {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.shortWeekday)
        return fmt.string(from: date)
    }
    
    static func getFullWeekdayStringByDate(_ date:Date?) -> String  {
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.fullWeekday)
        return fmt.string(from: date)
    }
    
    static func getWeekOfYear(_ date:Date = Date()) -> Int {
        let week = Calendar.current.component(.weekOfYear, from: date)
        return week
    }
    
    static func getWeekOfMonth(_ date:Date = Date()) -> Int {
        let week = Calendar.current.component(.weekOfMonth, from: date)
        return week
    }
    
    static func getStandardFormat(_ date:Date?) -> String{
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.standard)
        return fmt.string(from: date)
    }
    
    static func getMonthYearStringByDate(_ date:Date?) -> String{
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter.initWithFormat(.fullMonthYear)
        let day = fmt.string(from: date)
        return day
    }
    
    static func isSaturday(_ date:Date = Date()) -> Bool {
        let weekdayIndex = Calendar.current.component(.weekday, from: date)
        return weekdayIndex == 7
    }
    
    static func isBeginningOfWeek(_ date:Date = Date()) -> Bool {
        let weekdayIndex = Calendar.current.component(.weekday, from: date)
        return weekdayIndex == 1
    }
    
    static func isBeginningOfMonth(_ date:Date = Date()) -> Bool {
        let index = Calendar.current.component(.day, from: date)
        return index == 1
    }
    
    static func isToday(_ date:Date = Date()) -> Bool {
        let today = Date()
        return Date.isSameDate(today, date)
    }
    
    static func isSameDate(_ date1:Date, _ date2:Date) -> Bool{
        return Calendar.current.isDate(date1, equalTo: date2, toGranularity: .day)
    }
    
    static func isSameMonthAndDay(_ birthday:Date, _ date2:Date) -> Bool {
        let calendar = Calendar.current
        let birthdayComponents = calendar.dateComponents([.day, .month], from: birthday as Date)
        let dateComponents = calendar.dateComponents([.day, .month], from: date2 as Date)
        return birthdayComponents.month == dateComponents.month && birthdayComponents.day == dateComponents.day
    }
    
    static func startOfDay(_ date: Date) -> Date {
        let calendar = Calendar.current
        var todayComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        todayComponents.hour = 0
        todayComponents.minute = 0
        return calendar.date(from: todayComponents) ?? Date()
    }

    static func endOfDay(_ date: Date) -> Date {
        let calendar = Calendar.current
        var todayComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        todayComponents.hour = 23
        todayComponents.minute = 59
        return calendar.date(from: todayComponents) ?? Date()
    }
    
    static func dateSwapWIthHourMinute(_ date:Date, hour:Int, minute:Int ) -> Date {
        let calendar = Calendar.current
        var todayComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        todayComponents.hour = hour
        todayComponents.minute = minute
        return calendar.date(from: todayComponents) ?? Date()
    }
    
    static func dateSwapWithYearMonthAndDay(_ date:Date, year:Int, month:Int, day:Int ) -> Date {
        let calendar = Calendar.current
        var dayComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        dayComponents.year = year
        dayComponents.month = month
        dayComponents.day = day
        return calendar.date(from: dayComponents) ?? Date()
    }
    
    static func dateSwapWIthMonthAndDay(_ date:Date, month:Int, day:Int ) -> Date {
        let calendar = Calendar.current
        var todayComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        todayComponents.month = month
        todayComponents.day = day
        return calendar.date(from: todayComponents) ?? Date()
    }
    
    static func swapHourMinuteBetweenDates(_ date:Date, _ refDate:Date) -> Date{
        let calendar = Calendar.current
        let refComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: refDate as Date)
        var newComponents = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        newComponents.hour = refComponents.hour
        newComponents.minute = refComponents.minute
        return calendar.date(from: newComponents) ?? date
    }
    
    static func numberOfDaysBetweenExcludeEndDate(_ date1: Date, _ date2: Date, component:Calendar.Component = .day) -> Int {
        if Date.isSameDate(date1, date2) {
            return 0
        }
        let calendar = Calendar.current
        let numberOfDays = calendar.dateComponents([component], from: calendar.startOfDay(for: date1), to: calendar.startOfDay(for: date2))
        
        switch component {
            case .day:
                return numberOfDays.day!
            case.weekOfMonth:
                return numberOfDays.weekOfMonth!
            case .month:
                return numberOfDays.month!
            case.year:
                return numberOfDays.year!
            default:
                return 0
        }
    }
    
    static func numberOfDaysBetweenIncludeEndDate(_ date1: Date, _ date2: Date, component:Calendar.Component = .day) -> Int {
        if Date.isSameDate(date1, date2) {
            return 0
        }
        let calendar = Calendar.current
        let numberOfDays = calendar.dateComponents([component], from: calendar.startOfDay(for: date1), to: calendar.startOfDay(for: date2))
        
        switch component {
            case .day:
                return numberOfDays.day!
            case.weekOfMonth:
                return numberOfDays.weekOfMonth!
            case .month:
                return numberOfDays.month!
            case.year:
                return numberOfDays.year!
            default:
                return 0
        }
    }
    
    static func numberOfHourOrMinuteBetween(_ date1: Date, _ date2: Date, component:Calendar.Component = .hour) -> Int {
        let diff = Int(date2.timeIntervalSince1970 - date1.timeIntervalSince1970)
        if diff < 0 {
            return 0
        }
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        switch component {
        case .hour:
            return hours
        case.minute:
            var mins = 0
            if hours > 0 {
                mins = hours * 60
            }
            mins += minutes
            return mins
        default:
            return 0
        }
    }
    
    static func getFutureDaysBy(_ date:Date, _ interval:Int, component:Calendar.Component = .day) -> Date {
        let theDate:Date = Calendar.current.date(byAdding: component, value: interval, to: date) ?? date
        return theDate
    }
}
