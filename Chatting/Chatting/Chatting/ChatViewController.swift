//
//  ChatViewController.swift
//  Chatting
//
//  Created by 김수경 on 6/2/24.
//

import UIKit

class ChatViewController: UIViewController, ReuseIdentifiable {
    
    @IBOutlet var tableView: UITableView!

    var item: ChatRoom? {
        willSet {
            
            if let newValue {
                let dateFormatter = DateFormatter()
                var tempDateCount = Set<String>()
                var tempSectionItem = [[Chat]]()
                
                var index = 0
                for chat in newValue.chatList {
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    
                    if let date = dateFormatter.date(from: chat.date) {
                        dateFormatter.dateFormat = "yy.MM.dd"
            
                        let convertedDate = dateFormatter.string(from: date)
                        
                        tempDateCount.insert(convertedDate)
                        
                        if tempDateCount.count != index {
                            index = tempDateCount.count
                            tempSectionItem.append([chat])
                        } else {
                            tempSectionItem[tempSectionItem.count-1].append(chat)
                        }
                    }
                }
                headerTitle = Array(tempDateCount).sorted(by: < )
                newItem = tempSectionItem
            }
        }
    }
    
    private lazy var headerTitle = [String]()
    private lazy var newItem = [[Chat]]()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        guard let item else { return }
        
        navigationItem.title = item.chatroomName
        navigationItem.leftBarButtonItem?.tintColor = .black

    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: ChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.identifier)
        tableView.register(UINib(nibName: UserChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserChatTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        
        if let item = newItem.last {
            tableView.scrollToRow(at: IndexPath(row: item.count-1, section: newItem.count-1), at: .bottom, animated: true)
        }

    }
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        newItem.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newItem[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item {
            if newItem[indexPath.section][indexPath.row].user == .user {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UserChatTableViewCell.identifier, for: indexPath) as? UserChatTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.setContent(newItem[indexPath.section][indexPath.row])
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else {
                    return UITableViewCell()
                }
                cell.setContent(newItem[indexPath.section][indexPath.row])
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headerTitle[section]
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
