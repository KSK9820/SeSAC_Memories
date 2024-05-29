//
//  CityTableViewCell.swift
//  0524
//
//  Created by 김수경 on 5/28/24.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    
    static let identifier = "CityTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet var saveCountLabel: UILabel!
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var heartButton: UIButton!
    
    @IBOutlet var starImageView: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    private func setUI() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.textColor = .gray
        
        likeCountLabel.font = .systemFont(ofSize: 13)
        likeCountLabel.textColor = .lightGray
        
        saveCountLabel.font = .systemFont(ofSize: 13)
        saveCountLabel.textColor = .lightGray
        
        starImageView = starImageView.sorted { $0.tag < $1.tag }
        for star in starImageView {
            star.tintColor = .gray
        }
        heartButton.tintColor = .red
    }
    
    func setContext(_ data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        if let grade = data.grade {
            likeCountLabel.text = "(\(grade))"
            for index in 0..<Int(grade) {
                starImageView[index].image = UIImage(systemName: "star.fill")
                starImageView[index].tintColor = .systemYellow
            }
        }
        
        if let save = data.save {
            saveCountLabel.text = "저장 \(save.formatted())"
        }
        
        if let like = data.like, like {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        if let urlString = data.travel_image,
           let url = URL(string: urlString)  {
            cityImageView.kf.setImage(with: url)
        }
        
        cityImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        for star in starImageView {
            star.tintColor = .gray
        }
    }
}
