//
//  TextViewTableViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import UIKit
import SnapKit

final class TextViewTableViewCell: UITableViewCell {
    
    weak var delegate: TransferTableViewCellDataDelegate?
    
    private let contentTextView = UITextView()

    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal Method
    
    func setPlaceholder(_ placeholder: String?) {
        contentTextView.text = placeholder
        contentTextView.textColor = .gray
    }
    
    func removeTextViewContent() {
        contentTextView.text = nil
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(contentTextView)
    }
    
    private func configureLayout() {
        contentTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
    }
    
    private func configureUI() {
        contentTextView.font = .systemFont(ofSize: 16, weight: .medium)
        contentTextView.backgroundColor = .clear
        contentTextView.textContainer.maximumNumberOfLines = 4
        contentTextView.delegate = self
    }
    
}


extension TextViewTableViewCell: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        delegate?.textViewValueDidChange(value: textView.text)
        return true
    }
    
}
