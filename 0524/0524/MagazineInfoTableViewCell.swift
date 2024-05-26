//
//  MagazineInfoTableViewCell.swift
//  0524
//
//  Created by 김수경 on 5/24/24.
//

import UIKit

final class MagazineInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var travelView: UIView!
    @IBOutlet var travelImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUI() {
        travelImageView.layer.cornerRadius = 10
        
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = .preferredFont(forTextStyle: .body)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .gray
        
        dateLabel.textColor = .lightGray
    }

    
}
