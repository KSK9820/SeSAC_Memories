//
//  CreditHeaderView.swift
//  0604
//
//  Created by 김수경 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CreditHeaderView: UIView {
    
    let data: TrendResult
    
    private let backImage = UIImageView()
    private let posterImage = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    
    init(data: TrendResult) {
        self.data = data
        super.init(frame: .zero)

        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierarchy() {
        addSubview(backImage)
        addSubview(posterImage)
        addSubview(titleLabel)
    }
    
    private func configureLayout() {
        backImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview()
        }
        posterImage.snp.makeConstraints { make in
            make.bottom.equalTo(backImage.snp.bottom).inset(10)
            make.leading.equalToSuperview().offset(30)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(posterImage.snp.height).multipliedBy(0.6)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalTo(posterImage.snp.top)
        }
    }

    private func configureUI() {
        if let backdropPath = data.backdropPath {
            let url = URL(string: APIURL.tmdbPosterPath(backdropPath).urlString)
            backImage.kf.setImage(with: url)
        }
        if let posterPath = data.posterPath {
            let url = URL(string: APIURL.tmdbPosterPath(posterPath).urlString)
            posterImage.kf.setImage(with: url)
        }
        titleLabel.text = data.originalTitle
        posterImage.contentMode = .scaleAspectFit
        posterImage.clipsToBounds = true
        backImage.contentMode = .scaleAspectFill
    }
    
}
