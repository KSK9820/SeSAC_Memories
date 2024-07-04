//
//  TodoListTableViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {
    
    private let horizontalStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 20
        
        return view
    }()
    
    private let circleButton: UIButton = {
        let view = UIButton(type: .custom)
        
        view.setImage(UIImage(systemName: "circle"), for: .normal)
        view.tintColor = .white
        
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillProportionally
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.textColor = .white
        
        return view
    }()
    
    private let contentLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .gray
        
        return view
    }()
    
    private let smallStackView:  UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillProportionally
        
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .gray
        
        return view
    }()
    
    private let tagLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .blue
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ data: TodoDTO) {
        titleLabel.text = data.title
        contentLabel.text = "할일~"
        dateLabel.text = "2020.23.23"
        tagLabel.text = "#아아아ㅏ아앙"
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        horizontalStackView.addArrangedSubview(circleButton)
        horizontalStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(contentLabel)
        verticalStackView.addArrangedSubview(smallStackView)
        smallStackView.addArrangedSubview(dateLabel)
        smallStackView.addArrangedSubview(tagLabel)
        contentView.addSubview(horizontalStackView)
    }
    
    private func configureLayout() {
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
