//
//  BoxOfficeTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class BoxOfficeTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    let movieRank = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .red
        $0.backgroundColor = .yellow
    }
    
    let movieName = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
    }
    
    let movieDate = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .gray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(movieRank)
        contentView.addSubview(movieName)
        contentView.addSubview(movieDate)
        
        movieRank.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        movieName.snp.makeConstraints {
            $0.centerY.equalTo(movieRank)
            $0.leading.equalTo(movieRank.snp.trailing).offset(8)
            $0.trailing.equalTo(movieDate.snp.leading).offset(-8)
        }
        
        movieDate.snp.makeConstraints {
            $0.centerY.equalTo(movieRank)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    
}
