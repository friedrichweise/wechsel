//from https://github.com/zemirco/swift-timeago

import Foundation


public func timeAgoSince(_ date: Date) -> String {
    
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    
    if let year = components.year, year >= 2 {
        return String(format: NSLocalizedString("%d_YEARS_AGO", comment: ""), year)
    }
    
    if let year = components.year, year >= 1 {
        return NSLocalizedString("LAST_YEAR", comment: "")
    }
    
    if let month = components.month, month >= 2 {
        return String(format: NSLocalizedString("%d_MONTHS_AGO", comment: ""), month)
    }
    
    if let month = components.month, month >= 1 {
       return NSLocalizedString("LAST_MONTH", comment: "")
    }
    
    if let week = components.weekOfYear, week >= 2 {
        return String(format: NSLocalizedString("%d_WEEKS_AGO", comment: ""), week)
    }
    
    if let week = components.weekOfYear, week >= 1 {
        return NSLocalizedString("LAST_WEEK", comment: "")
    }
    
    if let day = components.day, day >= 2 {
        return String(format: NSLocalizedString("%d_DAYS_AGO", comment: ""), day)
    }
    
    if let day = components.day, day >= 1 {
        return NSLocalizedString("YESTERDAY", comment: "")
    }
    
    if let hour = components.hour, hour >= 2 {
        return String(format: NSLocalizedString("%d_HOURS_AGO", comment: ""), hour)
    }
    
    if let hour = components.hour, hour >= 1 {
        return NSLocalizedString("AN_HOUR_AGO", comment: "")
    }
    
    if let minute = components.minute, minute >= 2 {
        return String(format: NSLocalizedString("%d_MINUTES_AGO", comment: ""), minute)
    }
    
    if let minute = components.minute, minute >= 1 {
        return NSLocalizedString("A_MINUTE_AGO", comment: "")
    }
    
    if let second = components.second, second >= 3 {
        return String(format: NSLocalizedString("%d_SECONDS_AGO", comment: ""), second)
    }
    
    return NSLocalizedString("JUST_NOW", comment: "")
}
