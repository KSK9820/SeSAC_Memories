//
//  ClassifyCollectionViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/8/24.
//

import UIKit

final class ClassifyCollectionViewCell: UICollectionViewCell {
    
    private let verticalStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillProportionally
        view.spacing = 10

        return view
    }()
    
    private let iconImageView = UIImageView()
    private let iconTitleLabel = UILabel()
    private let itemCountLabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 30, weight: .bold)
        view.textColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContents(_ type: ClassifyTodo, itemCount: Int) {
        iconImageView.image = UIImage(systemName: type.image)
        iconImageView.tintColor = .white
        iconImageView.backgroundColor = type.backgroundColor
        
        iconTitleLabel.text = type.rawValue
        iconTitleLabel.textColor = .lightGray
        
        itemCountLabel.text = "\(itemCount)"
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(iconImageView)
        verticalStackView.addArrangedSubview(iconTitleLabel)
        contentView.addSubview(itemCountLabel)
    }
    
    private func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
        verticalStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
        }
        itemCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        iconImageView.layer.cornerRadius = 18
    }
    
    private func configureUI() {
        backgroundColor = TodoColor.cellBackgroundColor
    }
}

enum ClassifyTodo: String, CaseIterable {
    case today = "오늘"
    case schedule = "예정"
    case all = "전체"
    case flag = "고정"
    case complete = "완료됨"
    
    var image: String {
        switch self {
            
        case .today:
            return "heart.circle"
        case .schedule:
            return "calendar.circle"
        case .all:
            return "house.circle"
        case .flag:
            return "flag.circle"
        case .complete:
            return "checkmark.circle"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .today:
            return .yellow
        case .schedule:
            return .red
        case .all:
            return .gray
        case .flag:
            return .green
        case .complete:
            return .brown
        }
    }
}
