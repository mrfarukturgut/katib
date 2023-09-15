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
    private lazy var calendarView: PrayerCalendarView = {
        let calendarView = PrayerCalendarView()
        return calendarView
    }()
    
    private lazy var logView: PrayerLogView = {
        .init()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(calendarView)
        
        calendarView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        addSubview(logView)
        
        logView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(calendarView.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
