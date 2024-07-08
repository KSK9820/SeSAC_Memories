//
//  TodoListTableViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {
    
    private let fileManager = ImageFileManager()
    
    var indexPath: IndexPath?
    var finishTodo: (() -> Void)?
    
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
    
    private let todoImageView = {
        let view = UIImageView()
       
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 8
        
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
        view.distribution = .fill
        view.spacing = 12
        
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
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ data: TodoDTO) {
        titleLabel.text = Array(repeating: "⭐️", count: 4 - (data.priority ?? 4)).joined() + " " + data.title
        contentLabel.text = data.content
        dateLabel.text = data.dueDate?.toString(.ymd)
        tagLabel.text = data.tag
        circleButton.setImage(UIImage(systemName: data.isFinished ? "circle.circle.fill" : "circle"), for: .normal)
        if let image = data.imageName {
            todoImageView.image = fileManager.loadImageToDocument(filename: image)
        } else {
            todoImageView.isHidden = true
        }
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        horizontalStackView.addArrangedSubview(circleButton)
        horizontalStackView.addArrangedSubview(todoImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(contentLabel)
        verticalStackView.addArrangedSubview(smallStackView)
        smallStackView.addArrangedSubview(dateLabel)
        smallStackView.addArrangedSubview(tagLabel)
        contentView.addSubview(horizontalStackView)
    }
    
    private func configureLayout() {
        circleButton.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        
        todoImageView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(50)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func configureAction() {
        circleButton.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func circleButtonTapped() {
        finishTodo?()
    }
}
