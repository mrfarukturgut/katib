//
//  HorizontalWheelView.swift
//  katib
//
//  Created by Faruk Turgut on 27.08.2023.
//

import Combine
import Reusable
import SnapKit
import UIKit

class Cell: UICollectionViewCell, Reusable {
    private lazy var titleLabel: UILabel = {
        .init()
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .systemPurple
            } else {
                contentView.backgroundColor = .systemBlue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .systemBlue
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    
}

class CustomFlowLayout: UICollectionViewLayout {
    override func prepare() {
        super.prepare()
    }
}

class HorizontalWheelView: UIView {
    
    private var data: [String]
    
    let onSelected = PassthroughSubject<String, Never>()
    
    var selectedIndex: IndexPath?
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: Cell.self)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    init(data: [String], selection: String) {
        self.data = data
        if let index = data.firstIndex(of: selection) {
            self.selectedIndex = .init(row: index, section: 0)
        }
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        select(row: selectedIndex?.row ?? 0, animated: false, tell: false)
    }
    
    func select(row: Int, animated: Bool = true, tell: Bool = true) {
        guard row < data.count else { return }
        
        selectedIndex = nil
        
        let indexPath = IndexPath(row: row, section: 0)
        selectedIndex = indexPath
        onSelected.send(data[row])
        
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: .centeredHorizontally)
    }
}

extension HorizontalWheelView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setTitle(data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select(row: indexPath.row)
    }
}
