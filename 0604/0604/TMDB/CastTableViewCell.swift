//
//  CastTableViewCell.swift
//  0604
//
//  Created by 김수경 on 6/12/24.
//

import UIKit
import Kingfisher
import SnapKit

class CastTableViewCell: UITableViewCell {

    private let castImageView: UIImageView = {
        let view = UIImageView()
       
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let nameLabel = UILabel()
    private let characterNameLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 13)
        view.textColor = .lightGray
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierarchy() {
        contentView.addSubview(castImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterNameLabel)
    }
    
    private func configureLayout() {
        castImageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.directionalVerticalEdges.equalToSuperview().inset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(castImageView.snp.trailing).offset(12)
            make.bottom.equalTo(contentView.snp.centerY)
        }
        characterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(castImageView.snp.trailing).offset(12)
            make.top.equalTo(contentView.snp.centerY)
        }
    }
    
    func setContents(_ data: Cast) {
        if let path = data.profilePath {
            let url = URL(string: APIURL.tmdbPosterPath(path).urlString)
            castImageView.kf.setImage(with: url)
        } else {
            castImageView.backgroundColor = .gray
        }

        nameLabel.text = data.name
        characterNameLabel.text = data.character
    }
    
}
