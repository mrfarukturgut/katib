//
//  PrayerHistoryController.swift
//  katib
//
//  Created by Faruk Turgut on 26.08.2023.
//

import SnapKit
import UIKit

class PrayerHistoryController: UIViewController {
    
    private lazy var prayerHistoryView: PrayerHistoryView = {
        .init()
    }()
    
    override func loadView() {
        view = prayerHistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Prayer History"
        
        view.backgroundColor = .systemGreen
        
    }
}
