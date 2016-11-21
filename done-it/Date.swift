import Foundation

extension Date {
    func isGreaterThan(date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    func isLessThan(date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    func isEqualTo(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    
    func add(seconds: Int) -> Date {
        return add(timeUnit: .second, amount: seconds)
    }
    
    func add(minutes: Int) -> Date {
        return add(timeUnit: .minute, amount: minutes)
    }
    
    func add(hours: Int) -> Date {
        return add(timeUnit: .hour, amount: hours)
    }
    
    func add(days: Int) -> Date {
        return add(timeUnit: .day, amount: days)
    }
    
    func add(months: Int) -> Date {
        return add(timeUnit: .month, amount: months)
    }
    
    func add(years: Int) -> Date {
        return add(timeUnit: .year, amount: years)
    }
    
    private func add(timeUnit: Calendar.Component, amount: Int) -> Date {
        return Calendar.current.date(byAdding: timeUnit, value: amount, to: self)!
    }
}
