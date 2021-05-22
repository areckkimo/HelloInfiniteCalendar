//
//  CalendarHelper.swift
//  HelloSimpleCalendar
//
//  Created by 陳仕偉 on 2021/5/4.
//

import Foundation

class CalendarHelper: NSObject {
    let calendar = Calendar.current
    
    func nextMonth(date: Date) -> Date?{
        return calendar.date(byAdding: .month, value: 1, to: date)
    }
    
    func previousMonth(date: Date) -> Date?{
        return calendar.date(byAdding: .month, value: -1, to: date)
    }
    
    func dateByOffsetDays(_ days: Int, Of date: Date) -> Date?{
        return calendar.date(byAdding: .day, value: days, to: date)
    }
    
    func dateByOffsetMonths(_ months: Int, Of date: Date) -> Date? {
        return calendar.date(byAdding: .month, value: months, to: date)
    }
    
    func firstOfMonth(date: Date) -> Date?{
        let dateComponents = calendar.dateComponents([.month, .year], from: date)
        return calendar.date(from: dateComponents)
    }
    
    func weekDay(date: Date) -> Int? {
        let dateComponents = calendar.dateComponents([.weekday], from: date)
        if let weekday = dateComponents.weekday {
            return weekday - 1
        }
        return nil
    }
    
    func daysOfMonth(date: Date) -> Int?{
        if let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return nil
    }
    
    func yearString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date)
    }
    
    func dayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
        
    }
}
