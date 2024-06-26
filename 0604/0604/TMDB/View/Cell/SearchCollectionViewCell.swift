//
//  SearchCollectionViewCell.swift
//  0604
//
//  Created by 김수경 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

    
    func setContents(_ data: TrendResult) {
        if let path = data.posterPath {
            let url = URL(string: APIURL.tmdbPosterPath(path).urlString)
                imageView.kf.setImage(with: url)
        } else {
            imageView.backgroundColor = .gray
        }
    }
    
}
