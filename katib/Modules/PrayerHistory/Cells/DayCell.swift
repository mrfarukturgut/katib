//
//  DayCell.swift
//  katib
//
//  Created by Faruk Turgut on 26.08.2023.
//

import Reusable
import SnapKit
import UIKit

class DayCell: UICollectionViewCell, Reusable {
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
