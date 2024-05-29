//
//  TravelInfoTableViewCell.swift
//  0524
//
//  Created by 김수경 on 5/29/24.
//

import UIKit
import Kingfisher

final class TravelInfoTableViewCell: UITableViewCell {
    
    static let identifier = "TravelInfoTableViewCell"
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var explainNameLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyCornerRadius(to: cityImageView, corners: [.topLeft, .bottomRight], radius: 10)
    }
    
    private func configureUI() {
        cityNameLabel.textColor = .white
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        explainNameLabel.textColor = .white
        explainNameLabel.backgroundColor = .black.withAlphaComponent(0.2)
        
        cityImageView.contentMode = .scaleToFill
    }
    
    private func applyCornerRadius(to imageView: UIImageView, corners: UIRectCorner, radius: CGFloat) {
        // 이미지 뷰의 바운즈에 맞는 UIBezierPath 생성
        let path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        // CAShapeLayer 생성 및 path 설정
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        // 마스크로서 CAShapeLayer 적용
        imageView.layer.mask = maskLayer
    }
    
    func setContent(_ data: City) {
        cityNameLabel.text = "\(data.city_name) | \(data.city_english_name)"
        explainNameLabel.text = "\(data.city_explain)"
        cityImageView.kf.setImage(with: URL(string: data.city_image))
    }
}


