//
//  OverviewTableViewCell.swift
//  0604
//
//  Created by 김수경 on 6/12/24.
//

import UIKit

final class OverviewTableViewCell: UITableViewCell {
    
    private let overViewLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        
        return view
    }()
    
    private let expandButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .black
        view.backgroundColor = .white
        
        return view
    }()
    
    
    var isExpanded: Bool = false
    
    // MARK: - initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(overViewLabel)
        contentView.addSubview(expandButton)
    }
    
    private func configureLayout() {
        overViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectedBackgroundView?.backgroundColor = .clear
    }
    
    
    func setContents(_ data: String) {
        overViewLabel.text = data
    }
    
    @objc func expandButtonTapped() {
        isExpanded.toggle()
        
        expandButton.setImage(UIImage(systemName: isExpanded ? "chevron.up" : "chevron.down"), for: .normal)
        overViewLabel.numberOfLines = isExpanded ? 0 : 2
        
        invalidateIntrinsicContentSize()
    }
   
}
