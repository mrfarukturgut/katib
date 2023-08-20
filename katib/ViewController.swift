//
//  ViewController.swift
//  katib
//
//  Created by Faruk Turgut on 23.07.2023.
//

import UIKit
import Reusable
import SnapKit

class DayViewCollectionCell: UICollectionViewCell, Reusable {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textColor = .white
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.backgroundColor = .yellow
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(stackView.snp.top).inset(-8)
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
        }
        
        for prayer in ["Fajr","Dhuhr","Asr","Maghrib","Isha"] {
            stackView.addArrangedSubview(infoView(text: prayer))
        }
    }
    
    private func infoView(text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        let label = infoLabel(text: text)
        view.addSubview(label)
        
        let image = infoImage()
        view.addSubview(image)
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(4)
            make.height.equalTo(14)
        }
        
        image.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(4)
            make.height.width.equalTo(24)
        }
        
        return view
    }
    
    private func infoLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.backgroundColor = .systemBrown
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }
    
    private func infoImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemCyan
        imageView.image = UIImage(systemName: "square.and.pencil")
        return imageView
    }
    
}

struct Day {
    let title: String
}

class ViewController: UIViewController {
    
    var items: [Day] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .purple
        collectionView.register(cellType: DayViewCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var interval: DateInterval {
        DateInterval(start: .now.startDateOfMonth, end: .now)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        
        for day in 0...interval.totalNumberOfDays - 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateStyle = .short
            items.append(.init(title: dateFormatter.string(from: interval.dayFor(day))))
        }
        
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DayViewCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = items[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init()
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
