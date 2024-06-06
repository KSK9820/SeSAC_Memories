//
//  MovieTableViewCell.swift
//  0604
//
//  Created by 김수경 on 6/6/24.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    private let numberLabel: UILabel = {
        let view = UILabel()
        
        view.backgroundColor = .white
        view.textColor = .black
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16, weight: .bold)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 14, weight: .semibold)
        view.textColor = .white
        
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 12, weight: .light)
        view.textColor = .white
        
        return view
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierarchy() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func configureLayout() {
        numberLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(numberLabel.snp.trailing).offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-8)
        }
    }
    
    func setContents(_ data: DailyBoxOfficeList) {
        numberLabel.text = data.rank
        titleLabel.text = data.movieNm
        dateLabel.text = data.openDt
    }
}
