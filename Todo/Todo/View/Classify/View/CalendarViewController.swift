//
//  CalendarViewController.swift
//  Todo
//
//  Created by 김수경 on 7/9/24.
//

import UIKit
import FSCalendar

final class CalendarViewController: UIViewController {

    private let viewModel = CalendarViewModel()
    
    private let calendar = FSCalendar()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        bindingData()
    }
    
    private func bindingData() {
        viewModel.todoData.bind { data in
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(calendar)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        calendar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeArea).inset(12)
            make.height.equalTo(calendar.snp.width)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeArea).inset(12)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        configureCalendar()
        configureTableView()
    }
    
    private func configureCalendar() {
        calendar.delegate = self
        calendar.scrollEnabled = true
        calendar.scrollDirection = .vertical
        calendar.appearance.headerTitleColor = .gray
        calendar.appearance.titleDefaultColor = .white
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .black
    }
}

extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.readTodoData(date)
    }
    
}


extension CalendarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoData.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as? TodoListTableViewCell else { return UITableViewCell() }
        
        if let data = viewModel.todoData.value {
            cell.setContent(data[indexPath.row])
        }
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
}
