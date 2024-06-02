//
//  ChatTableViewCell.swift
//  Chatting
//
//  Created by 김수경 on 6/2/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell, ReuseIdentifiable {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabelView: UIView!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        configureUI()
    }


    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width / 2
        
        nameLabel.font = .systemFont(ofSize: 14)
        
        chatLabelView.layer.cornerRadius = 12
        chatLabelView.layer.borderWidth = 1
        chatLabelView.layer.borderColor = UIColor.lightGray.cgColor
        
        chatLabel.numberOfLines = 0
        chatLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 11, weight: .light)
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func setContent(_ data: Chat) {
        profileImageView.image = UIImage(named: data.user.profileImage)
        
        nameLabel.text = data.user.rawValue
        
        chatLabel.text = data.message
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
   
        if let convertedDate = dateFormatter.date(from: data.date) {
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateLabel.text = dateFormatter.string(from: convertedDate)
        }
       
    }
}
