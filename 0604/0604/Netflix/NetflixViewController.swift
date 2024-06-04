//
//  NetflixViewController.swift
//  0604
//
//  Created by 김수경 on 6/4/24.
//

import UIKit

class NetflixViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "비쵸비님"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private let posterImage: UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage.playNormal, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private let pickButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.setTitle("내가 찜한 리스트", for: .normal)
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        
        return view
    }()
    
    private let nowContentLabel: UILabel = {
        let label = UILabel()
        
        label.text = "지금 뜨는 콘텐츠"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    private let imageStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        
        return view
    }()
    
    private let smallPosterimages: [UIView] = [SmallPoster(), SmallPoster(), SmallPoster()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        getRandomMoviePoster()
        getRandomDeco()
    }
    
    
    private func configureHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(posterImage)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(pickButton)
        view.addSubview(buttonStackView)
        
        view.addSubview(nowContentLabel)
        smallPosterimages.forEach { view in
            imageStackView.addArrangedSubview(view)
        }
        view.addSubview(imageStackView)
        
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(10)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        posterImage.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea).inset(30)
            make.height.equalTo(posterImage.snp.width).multipliedBy(1.3)
        }
        
        playButton.snp.makeConstraints { make in
            make.width.equalTo(pickButton)
            make.height.equalTo(40)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(posterImage).inset(10)
            make.bottom.equalTo(posterImage.snp.bottom).offset(-10)
            make.height.equalTo(40)
        }
        
        nowContentLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.equalTo(safeArea.snp.leading).offset(30)
        }
        
        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(nowContentLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeArea).inset(30)
            make.height.equalTo(150)
        }
    }
    
    private func getRandomMoviePoster() {
        let movie = ["1", "2", "3", "4", "5"].shuffled()
        
        posterImage.image = UIImage(named: movie[0])
        imageStackView.arrangedSubviews.enumerated().forEach { index, subview in
            if let imageView = subview as? SmallPoster {
                imageView.setImage(movie[index + 1])
            }
        }
    }
    
    private func getRandomDeco() {
        imageStackView.arrangedSubviews.forEach { subview in
            if let imageView = subview as? SmallPoster {
                let badge: Bool = Bool.random()
                let label: Bool = Bool.random()
                imageView.setInvisible(badge: badge, label: label)
            }
        }
    }
    
}

