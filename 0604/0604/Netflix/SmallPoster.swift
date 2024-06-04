//
//  SmallPoster.swift
//  0604
//
//  Created by 김수경 on 6/5/24.
//

import UIKit
import SnapKit

final class SmallPoster: UIView {

    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private let badgeImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage.top10Badge
        
        return view
    }()
    
    private let newSeriesLabel: UILabel = {
       let label = UILabel()
        
        label.text = "새로운 시리즈"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 4
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(imageView)
        addSubview(badgeImageView)
        addSubview(newSeriesLabel)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        badgeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        newSeriesLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func setImage(_ name: String) {
        imageView.image = UIImage(named: name)
    }
    
    func setInvisible(badge: Bool, label: Bool) {
        if badge {
            badgeImageView.isHidden = true
        } else {
            badgeImageView.isHidden = false
        }
    
        if label {
            newSeriesLabel.isHidden = true
        } else {
            newSeriesLabel.isHidden = false
        }
    }
    

}
