//
//  SearchCollectionViewCell.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/12/24.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher

final class SearchCollectionViewCell: UICollectionViewCell {

    private let thumbnailImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
    }
    private let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 15
    }
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    private let starView = UIView()
    private let starImage = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
    }
    private let starLabel = UILabel().then {
        $0.textColor = .gray
    }
    private let companyLabel = UILabel().then {
        $0.textColor = .gray
    }
    private let genreLabel = UILabel().then {
        $0.textColor = .gray
    }
    private let ImageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    private let screenshotImage = [
        UIImageView().then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        },
        UIImageView().then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        },
        UIImageView().then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
        ]
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        [thumbnailImage, titleLabel, downloadButton, stackView, ImageStackView].forEach { view in
            contentView.addSubview(view)
        }
        [starImage, starLabel].forEach { view in
            starView.addSubview(view)
        }
        [starView, companyLabel, genreLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
        screenshotImage.forEach { view in
            ImageStackView.addArrangedSubview(view)
        }
    }
    
    private func configureLayout() {
        thumbnailImage.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.leading.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(thumbnailImage.snp.centerY)
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(10)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-10)
        }
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(thumbnailImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(60)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        starImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().inset(2)
        }
        starLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(starImage.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-2)
        }
        ImageStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func setContents(_ content: AppStoreResult) {
        if let thumbnailurl = URL(string: content.artworkUrl60) {
            thumbnailImage.kf.setImage(with: thumbnailurl)
        }
        titleLabel.text = content.trackCensoredName
        starLabel.text = String(format: "%.1f", content.averageUserRating)
        companyLabel.text = content.artistName
        genreLabel.text = content.genres[0]
        
        for image in 0..<3 {
            if let url = URL(string: content.screenshotUrls[image]) {
                screenshotImage[image].kf.setImage(with: url)
            }
        }
        
    }
}

