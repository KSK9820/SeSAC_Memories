//
//  LabelTableViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import UIKit

final class LabelTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .white
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    private let contentLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .white
        view.font = .systemFont(ofSize: 15)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func removeContent() {
        contentLabel.text = ""
    }
    
    func setContent(_ text: String?) {
        contentLabel.text = text
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    private func configureUI() {
        let disclosureImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let disclosureIndicator = UIImageView(image: disclosureImage)
        disclosureIndicator.tintColor = .lightGray
        self.accessoryView = disclosureIndicator
    }
    
}
