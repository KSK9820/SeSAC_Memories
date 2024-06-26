//
//  ContentImageCollectionViewCell.swift
//  0604
//
//  Created by 김수경 on 6/24/24.
//

import UIKit

final class ContentImageCollectionViewCell: UICollectionViewCell {
    
    private let contentImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ data: TrendResult) {
        if let path = data.posterPath {
            let url = URL(string: APIURL.tmdbPosterPath(path).urlString)
            contentImageView.kf.setImage(with: url)
        } else {
            contentImageView.backgroundColor = .gray
        }
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(contentImageView)
    }
    
    private func configureLayout() {
        contentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureUI() {
        contentImageView.clipsToBounds = true
        contentImageView.layer.cornerRadius = 8
        contentImageView.contentMode = .scaleAspectFit
    }
}
