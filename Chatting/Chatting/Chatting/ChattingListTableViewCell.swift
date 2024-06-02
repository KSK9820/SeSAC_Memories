//
//  ChattingListTableViewCell.swift
//  Chatting
//
//  Created by 김수경 on 6/2/24.
//

import UIKit

class ChattingListTableViewCell: UITableViewCell, ReuseIdentifiable {

    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configureUI()
    }


    private func configureUI() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width / 2
        
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        chatLabel.font = .systemFont(ofSize: 13)
        chatLabel.textColor = .gray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    
    func setContents(_ data: ChatRoom) {
        if let chatroomImage = data.chatroomImage.first {
            profileImageView.image = UIImage(named: chatroomImage)
        }
        
        nameLabel.text = data.chatroomName
        
        if let lastChat = data.chatList.last {
            chatLabel.text = lastChat.message
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
       
            if let convertedDate = dateFormatter.date(from: lastChat.date) {
                dateFormatter.dateFormat = "yy.MM.dd"
                dateLabel.text = dateFormatter.string(from: convertedDate)
            }
        }
    }
}
