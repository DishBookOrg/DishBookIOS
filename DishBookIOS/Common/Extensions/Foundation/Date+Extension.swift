//
//  Date+Extension.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 03.02.2021.
//

import Foundation

extension Date {
    
    static var yesterday: Date {
        return Date().dayBefore
    }
    
    static var tomorrow: Date {
        return Date().dayAfter
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func isEqual(inputDate: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        return calendar.isDate(self, equalTo: inputDate, toGranularity: component)
    }
    
    func dateInSeconds() -> Int {
        
        return Int((self.timeIntervalSince1970).rounded())
    }
    
    func getComponents() -> DateComponents {
        
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        
        return DateComponents(year: year, month: month, day: day)
    }
    
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    var isToday: Bool {
        return Date().noon == noon
    }
}
