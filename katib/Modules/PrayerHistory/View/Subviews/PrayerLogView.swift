//
//  PrayerLogView.swift
//  katib
//
//  Created by Faruk Turgut on 13.09.2023.
//

import SnapKit
import Reusable
import UIKit

struct Month {
    let date: Date
    
    var days: [Date] {
        Array(Calendar.current.range(of: .day, in: .month, for: date)!).map({ Calendar.current.date(byAdding: .day, value: $0 - 1, to: date.startDateOfMonth)! })
    }
    
    var previous: Month? {
        .init(date: date.previousMonth!)
    }
    
    var next: Month? {
        .init(date: date.nextMonth!)
    }
}

extension Date {
    var nextMonth: Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    var previousMonth: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
}

struct Source {
    let current: Month
    
    var data: [Date] {
        [current.previous?.days, current.days, current.next?.days].compactMap({ $0 }).flatMap({ $0 })
    }
}

class LogCell: UICollectionViewCell, Reusable {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var logView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .systemBlue
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(2)
        }
        
        contentView.addSubview(logView)
        
        logView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
}

class PrayerLogView: UIView {
    let source = Source(current: .init(date: .now))
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: LogCell.self)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PrayerLogView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        source.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LogCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setTitle(source.data[indexPath.row].formatted())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 24, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 12, left: 12, bottom: 12, right: 12)
    }
    
}
