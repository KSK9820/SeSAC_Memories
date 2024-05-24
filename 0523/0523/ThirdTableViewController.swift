//
//  ThirdTableViewController.swift
//  0523
//
//  Created by 김수경 on 5/23/24.
//

import UIKit

struct ShoppingList {
    let list: String
    var checkmark: Bool
    var bookmark: Bool
}

class ThirdTableViewController: UITableViewController {
    
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shopping: [ShoppingList] = [
        ShoppingList(list: "그립톡 구매하기", checkmark: false, bookmark: false),
        ShoppingList(list: "사이다 구매하기", checkmark: false, bookmark: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        searchView.backgroundColor =  .lightGray.withAlphaComponent(0.1)
        searchView.layer.cornerRadius = 12
        
        searchTextField.borderStyle = .none
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
        
        addButton.backgroundColor = .lightGray.withAlphaComponent(0.2)
        addButton.tintColor = .black
        addButton.layer.cornerRadius = 12
        
    }
    
    // MARK: - Table view data source
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let item = searchTextField.text,
              item.count > 2 
        else { return }

        shopping.append(ShoppingList(list: item, checkmark: false, bookmark: false))
        tableView.insertRows(at: [IndexPath(row: shopping.count - 1, section: 0)], with: .automatic)
        
        searchTextField.text = ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopping.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.checkMarkButton.setImage(UIImage(systemName: shopping[indexPath.row].checkmark ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        cell.checkMarkButton.tintColor = .black
        cell.checkMarkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        cell.checkMarkButton.tag = indexPath.row
        
        cell.itemLabel.text = shopping[indexPath.row].list
        
        cell.bookmarkButton.setImage(UIImage(systemName: shopping[indexPath.row].bookmark ? "bookmark.fill" : "bookmark"), for: .normal)
        cell.bookmarkButton.tintColor = .black
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        cell.bookmarkButton.tag = indexPath.row
        return cell
    }
    
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        shopping[sender.tag].checkmark.toggle()
       
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        shopping[sender.tag].bookmark.toggle()
       
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}
