//
//  Extensions.swift
//  katib
//
//  Created by Faruk Turgut on 26.08.2023.
//

import Foundation

extension DateInterval {
    var totalNumberOfDays: Int {
        Calendar.current.numberOfDaysBetween(fromDate: start, to: end)
    }
    
    func dayFor(_ index: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -index, to: end) ?? .init()
    }
}

extension Calendar {
    func numberOfDaysBetween(fromDate from: Date, to: Date) -> Int {
        (dateComponents([.day], from: startOfDay(for: from), to: startOfDay(for: to)).day ?? 0) + 1
    }
}

extension Date {
    private var components: DateComponents {
        Calendar.current.dateComponents([.year, .month], from: self)
    }
    
    var startDateOfMonth: Date {
        guard let date = Calendar.current.date(from: components) else {
            fatalError()
        }
        return date
    }
}
