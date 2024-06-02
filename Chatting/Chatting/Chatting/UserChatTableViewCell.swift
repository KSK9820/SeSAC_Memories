//
//  UserChatTableViewCell.swift
//  Chatting
//
//  Created by 김수경 on 6/2/24.
//

import UIKit

class UserChatTableViewCell: UITableViewCell, ReuseIdentifiable {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var chatLabelView: UIView!
    @IBOutlet var chatLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        configureUI()
    }

    private func configureUI() {
        chatLabelView.layer.cornerRadius = 12
        chatLabelView.layer.borderWidth = 1
        chatLabelView.layer.borderColor = UIColor.lightGray.cgColor
        chatLabelView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        
        chatLabel.numberOfLines = 0
        chatLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 11, weight: .light)
    }
    
    func setContent(_ data: Chat) {
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
