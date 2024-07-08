
//
//  TodoListViewController.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import UIKit
import SnapKit

final class TodoListViewController: UIViewController {
    
    private let viewModel: TodoListViewModel
    
    private var searchController = UISearchController()
    
    private let tableView = UITableView()
    
    var backAction: (() -> Void)?
    
    init(_ viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        databinding()
    }
    
    private func databinding() {
        viewModel.todoData.bind { [weak self] data in
            self?.tableView.reloadData()
        }
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
        configureSearchController()
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
        let optionButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        optionButton.menu = createMenu()
        navigationItem.rightBarButtonItem = optionButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.title = viewModel.classifyType.rawValue
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
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .clear
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Todos"
        
        searchController.searchBar.searchBarStyle = .minimal
        
        // 검색 바 스타일 설정
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .black
        
        // 검색 바 텍스트 필드 스타일 설정
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
            textField.textColor = .black
            if let backgroundView = textField.subviews.first {
                backgroundView.backgroundColor = .white
                backgroundView.layer.cornerRadius = 10
                backgroundView.clipsToBounds = true
            }
        }
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
    
    private func createMenu() -> UIMenu {
        let highPriority = UIAction(title: "중요도 높은 순") { [weak self] action in
            self?.viewModel.readTodoData(sort: ("priority", .asc))
        }
        let lowPriority = UIAction(title: "중요도 낮은 순") { [weak self] action in
            self?.viewModel.readTodoData(sort: ("priority", .des))
        }
        
        let highName = UIAction(title: "이름 높은 순") { [weak self] action in
            self?.viewModel.readTodoData(sort: ("title", .asc))
        }
        
        let lowName = UIAction(title: "이름 낮은 순") { [weak self] action in
            self?.viewModel.readTodoData(sort: ("title", .des))
        }
        
        let latestDate = UIAction(title: "마감 기한 빠른 순") { [weak self] action in
            self?.viewModel.readTodoData(sort: ("dueDate", .asc))
        }
        
        let lateDate = UIAction(title: "마감 기한 늦은 순") { [weak self] action in
            self?.viewModel.readTodoData(sort: ("dueDate", .des))
        }
        
        return UIMenu(title: "", children: [highPriority, lowPriority, highName, lowName, latestDate, lateDate])
    }
    
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
}


extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = viewModel.todoData.value {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as? TodoListTableViewCell else { return UITableViewCell() }
        
        if let data = viewModel.todoData.value {
            cell.setContent(data[indexPath.row])
        }
        cell.backgroundColor = .clear
        cell.finishTodo = { [weak self] in
            self?.viewModel.updateToggleData(indexPath, item: "isFinished")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .normal, title: "delete") { [weak self] action, view, completion in
            self?.viewModel.updateTodoData(indexPath)
        }
        let fix = UIContextualAction(style: .normal, title: "fix") { [weak self] action, view, completion in
            self?.viewModel.updateToggleData(indexPath, item: "isFix")
        }
        
        return UISwipeActionsConfiguration(actions: [remove, fix])
    }
    
}


extension TodoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            viewModel.readTodoData()
            return
        }
        viewModel.readTodoData(search: searchText)
    }
}
