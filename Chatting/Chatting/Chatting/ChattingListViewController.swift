//
//  ChattingListViewController.swift
//  Chatting
//
//  Created by 김수경 on 6/2/24.
//

import UIKit

class ChattingListViewController: UIViewController {
    
    var chattingList: [ChatRoom] = mockChatList {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var searchTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }

    
    private func configureUI() {
        navigationItem.title = "TRAVEL TALK"
        
        headerView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        headerView.layer.cornerRadius = 12
        
        searchImageView.tintColor = .gray
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        
        searchTextView.borderStyle = .none
        searchTextView.placeholder = "친구 이름을 검색해보세요"
        searchTextView.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ChattingListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChattingListTableViewCell.identifier)
    }
    
    @objc func textFieldValueChanged() {
        guard let text = searchTextView.text else { return }
        
        if text == "" {
            chattingList = mockChatList
        } else {
            chattingList = []
            for list in mockChatList {
                if list.chatroomName.lowercased().contains(text.lowercased()) {
                    chattingList.append(list)
                }
            }
        }
        
    }
    

}

extension ChattingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chattingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingListTableViewCell.identifier, for: indexPath) as? ChattingListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContents(chattingList[indexPath.row])
        
        return cell
    }
    
    
}

extension ChattingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: ChatViewController.identifier) as? ChatViewController else { return }
        vc.item = chattingList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
