//
//  RestaurantTableViewCell.swift
//  0524
//
//  Created by 김수경 on 5/28/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    static let identifier = "RestaurantTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    private func configureUI() {
        restaurantImageView.contentMode = .scaleAspectFit
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 0
        categoryLabel.font = .systemFont(ofSize: 15)
        categoryLabel.textColor = .gray
        addressLabel.numberOfLines = 0
    }
    
    func setContext(_ data: Restaurant) {
        if let url = URL(string: data.image) {
            restaurantImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = data.name
        categoryLabel.text = data.category
        addressLabel.text = data.address
        phoneNumberLabel.text = data.phoneNumber
        priceLabel.text = "\(data.price)"
    }
    
    
    
}
