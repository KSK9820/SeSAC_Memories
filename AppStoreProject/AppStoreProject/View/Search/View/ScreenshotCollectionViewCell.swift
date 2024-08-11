//
//  ScreenshotCollectionViewCell.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/12/24.
//

import UIKit

final class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(_ url: URL?) {
        imageView.kf.setImage(with: url)
    }
    
}
