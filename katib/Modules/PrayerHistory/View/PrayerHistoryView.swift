//
//  PrayerHistoryView.swift
//  katib
//
//  Created by Faruk Turgut on 27.08.2023.
//

import SnapKit
import UIKit

class PrayerHistoryView: UIView {
    
    private lazy var wheel: HorizontallWheelView = .init()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemPink
        
        addSubview(wheel)
        
        wheel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
