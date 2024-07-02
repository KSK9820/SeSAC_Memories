//
//  LabelTableViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import UIKit

final class LabelTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()

    
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
        var content = defaultContentConfiguration()
        content.text = title
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16.0)
        ]
        content.attributedText = NSAttributedString(string: title, attributes: attributes)
     
        self.contentConfiguration = content
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    private func configureUI() {
        let disclosureImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let disclosureIndicator = UIImageView(image: disclosureImage)
        disclosureIndicator.tintColor = .lightGray
        self.accessoryView = disclosureIndicator
    }
    
}
