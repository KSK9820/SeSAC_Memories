//
//  TrendTableViewCell.swift
//  0604
//
//  Created by 김수경 on 6/10/24.
//

import UIKit
import Kingfisher

final class TrendTableViewCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let view = UILabel()
       
        view.textColor = .gray
        view.font = .systemFont(ofSize: 13)
        
        return view
    }()
    
    private let typeLabel: UILabel = {
        let view = UILabel()
       
        view.font = .systemFont(ofSize: 18, weight: .bold)
        
        return view
    }()
    
    private let view: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        return view
    }()
    
    private let posterImage = UIImageView()
    private let scoreStack: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    private let scoreLabel1: UILabel = {
        let view = UILabel()
       
        view.text = " 평점 "
        view.backgroundColor = .purple
        view.textColor = .white
        
        return view
    }()
    
    private let scoreLabel2: UILabel = {
        let view = UILabel()
       
        view.backgroundColor = .white
        view.textColor = .black
        view.textAlignment = .center
        
        return view
    }()
    
    
    private let titleLabel: UILabel = {
        let view = UILabel()
       
        view.font = .systemFont(ofSize: 24, weight: .semibold)
        
        return view
    }()
    
    private let overViewLabel: UILabel = {
        let view = UILabel()
       
        view.font = .systemFont(ofSize: 16, weight: .light)
        
        return view
    }()
    
    private let boundaryView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        
        return view
    }()
    
    private let detailStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillProportionally
        
        return view
    }()
    
    private let detailLabel: UILabel = {
        let view = UILabel()
       
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.textColor = .gray
        view.text = "자세히 보기"
        
        return view
    }()
    
    private let detailImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "chevron.forward")
        view.tintColor = .black
        
        return view
    }()
    
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
    
    // MARK: - UI Configure
    
    private func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(typeLabel)
        view.addSubview(posterImage)
        view.addSubview(scoreStack)
        scoreStack.addArrangedSubview(scoreLabel1)
        scoreStack.addArrangedSubview(scoreLabel2)
        view.addSubview(titleLabel)
        view.addSubview(overViewLabel)
        view.addSubview(boundaryView)
        detailStackView.addArrangedSubview(detailLabel)
        detailStackView.addArrangedSubview(detailImage)
        view.addSubview(detailStackView)
        contentView.addSubview(view)
    }

    private func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(view.snp.leading)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.equalTo(view.snp.leading)
        }
        view.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(view.snp.width)
        }
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        scoreStack.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.leading).offset(20)
            make.bottom.equalTo(posterImage.snp.bottom).inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        detailStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(boundaryView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        detailImage.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
    }
    
    private func configureUI() {
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        posterImage.layer.cornerRadius = 8
    }
    

    func setContents(_ data: TrendResult) {
        dateLabel.text = data.releaseDate
        typeLabel.text = data.mediaType
        
        if let posterPath = data.posterPath {
            let url = URL(string: APIURL.tmdbPosterPath(posterPath).urlString)
            posterImage.kf.setImage(with: url)
            
        }
        scoreLabel2.text = String(format: "%.2f", data.voteAverage)
        titleLabel.text = data.originalTitle
        overViewLabel.text = data.overview
    }
    
}
