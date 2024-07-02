//
//  TextFieldTableViewCell.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import UIKit
import SnapKit

final class TextFieldTableViewCell: UITableViewCell {
    
    private let titleTextField = UITextField()
    weak var delegate: TransferTableViewCellDataDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPlaceholder(_ placeholder: String?) {
        titleTextField.placeholder = placeholder
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16.0) 
        ]
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: titleTextField.placeholder ?? "", attributes: attributes)
    }
    
    func removeTextFieldContent() {
        titleTextField.text = nil
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(titleTextField)
    }
    
    private func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    private func configureAction() {
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc
    func textFieldDidChange() {
        delegate?.textFieldValueDidChange?(value: titleTextField.text)
    }
}

