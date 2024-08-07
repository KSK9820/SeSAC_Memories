//
//  ShoppingListTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/3/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


final class ShoppingListTableViewCell: UITableViewCell {
    
    let checkboxButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.tintColor = .black
    }
    let titleLabel = UILabel()
    let starButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.tintColor = .black
    }
    
    var disposeBag = DisposeBag()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(_ content: ShoppingList) {
        titleLabel.text = content.title
        starButton.setImage(UIImage(systemName: content.star ? "star.fill" : "star"), for: .normal)
        checkboxButton.setImage(UIImage(systemName: content.done ? "checkmark.square" : "square"), for: .normal)
    }
    
    func toggleCheckbox(_ done: Bool) {
        checkboxButton.setImage(UIImage(systemName: done ? "checkmark.square" : "square"), for: .normal)
    }
    
    func toggleStarButton(_ star: Bool) {
        starButton.setImage(UIImage(systemName: star ? "star.fill" : "star"), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starButton)
    }
    
    private func configureLayout() {
        checkboxButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
        }
        starButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkboxButton.snp.trailing).offset(20)

            make.centerY.equalTo(contentView)
        }
    }

    private func configureUI() {
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        layer.cornerRadius = 8
    }
    
}
