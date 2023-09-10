//
//  PrayerHistoryView.swift
//  katib
//
//  Created by Faruk Turgut on 27.08.2023.
//

import Combine
import SnapKit
import UIKit

class PrayerHistoryView: UIView {
    
    private lazy var yearWheel: HorizontalWheelView = .init(data: Array(1970...2023).map({ "\($0)"}), selection: selectedYear)
    private lazy var monthWheel: HorizontalWheelView = .init(data: Calendar.current.monthSymbols, selection: selectedMonth)
    private lazy var dayWheel: HorizontalWheelView = .init(data: Array(days()).map({ "\($0)" }), selection: selectedDay)
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    private var selectedYear: String
    private var selectedMonth: String
    private var selectedDay: String
    
    init() {
        selectedYear = Date.now.year
        selectedMonth = Date.now.month
        selectedDay = Date.now.day
        
        super.init(frame: .zero)
        
        backgroundColor = .systemPink
        
        addSubview(yearWheel)
        
        yearWheel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(monthWheel)
        
        monthWheel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(yearWheel.snp.bottom).offset(8)
        }
        
        addSubview(dayWheel)
        
        dayWheel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(monthWheel.snp.bottom).offset(8)
        }
        
        yearWheel
            .onSelected
            .sink { [weak self] selectedYear in
                self?.selectedYear = selectedYear
            }
            .store(in: &subscriptions)
        
        monthWheel
            .onSelected
            .sink { [weak self] selectedMonth in
                self?.selectedMonth = selectedMonth
            }
            .store(in: &subscriptions)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func days() -> Range<Int> {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = "MMMM yyyy"
        let date = formatter.date(from: "\(selectedMonth) \(selectedYear)")
        
        let range = Calendar.current.range(of: .day, in: .month, for: date!)
        
        return range!
    }
}

extension Date {
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        return formatter
    }
    
    private func formatter(dateFormat format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = format
        return formatter
    }
    
    var year: String {
        formatter(dateFormat: "yyyy").string(from: self)
    }
    
    var month: String {
        formatter(dateFormat: "MMMM").string(from: self)
    }
    
    var day: String {
        formatter(dateFormat: "d").string(from: self)
    }
    
}
