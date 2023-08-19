//
//  ViewController.swift
//  katib
//
//  Created by Faruk Turgut on 23.07.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var interval: DateInterval {
        DateInterval(start: .now.startDateOfMonth, end: .now)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        for day in 0...interval.totalNumberOfDays - 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateStyle = .short
            print(dateFormatter.string(from: interval.dayFor(day)), "-", "\(interval.dayFor(day))")
        }
    }
}

extension DateInterval {
    var totalNumberOfDays: Int {
        Calendar.current.numberOfDaysBetween(fromDate: start, to: end)
    }
    
    func dayFor(_ index: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: index, to: start) ?? .init()
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
