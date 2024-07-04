//
//  TodoListViewController.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import UIKit
import SnapKit

final class TodoListViewController: UIViewController {
    
    private let viewModel = TodoListViewModel()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea).inset(10)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = TodoColor.backgroundColor
        configureNavigation()
        configureTableView()
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.title = "전체"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .automatic
        
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}


extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = viewModel.todoData {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as? TodoListTableViewCell else { return UITableViewCell() }
        
        if let data = viewModel.todoData {
            cell.setContent(data[indexPath.row])
        }
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .normal, title: "delete") { [weak self] action, view, completion in
            self?.viewModel.removeTodoData(indexPath, completion: { result in
                switch result {
                case true:
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                case false:
                    self?.makeAlert(title: "삭제 실패", message: "삭제에 실패하였습니다.", option: nil, completion: nil)
                }
            })
        }
        
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
}
