//
//  ViewController.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import UIKit
import SnapKit

final class AddNewTodoViewController: UIViewController {
    
    private let viewModel = AddNewToDoViewModel()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let tableViewSectionTitle = [["제목", "메모"], ["마감일"], ["태그"], ["우선 순위"], ["이미지 추가"]]
    var dismissAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldTableViewCell {
//            cell.removeTextFieldContent()
//        }
//        if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TextViewTableViewCell {
//            cell.removeTextViewContent()
//        }
//    }
    
 
    
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
        view.backgroundColor = .black
        
        configureNavitaion()
        configureTableView()
    }
    
    private func configureNavitaion() {
        navigationItem.title = "새로운 할일 추가하기"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cnacelButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(appendButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.reuseIdentifier)
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: TextViewTableViewCell.reuseIdentifier)
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: LabelTableViewCell.reuseIdentifier)
        
        tableView.backgroundColor = .clear
        
    }
    
    @objc
    func appendButtonTapped() {
        
        viewModel.validateInput { [weak self] result in
            switch result {
            case true:
                let vm = TodoListViewModel(.all)
                let vc = TodoListViewController(vm)
                self?.dismiss(animated: false)
                self?.dismissAction?()
            case false:
                self?.makeAlert(title: "저장 실패", message: "다시 시도해주세요.", option: nil, completion: nil)
            }
        }
        
    }
    
    @objc
    private func cnacelButtonTapped() {
        dismiss(animated: false)
    }
}


extension AddNewTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tableViewSectionTitle[section].count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                // 재사용되지 않는 경우 굳이 tableview?? -> 그렇지만 delegate 기능 활용할 수 있음
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier) as? TextFieldTableViewCell else { return UITableViewCell() }
                
                cell.setPlaceholder(tableViewSectionTitle[indexPath.section][indexPath.row])
                cell.backgroundColor = TodoColor.cellBackgroundColor
                cell.delegate = self
                cell.selectionStyle = .none
                
                return cell
            }
            if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.reuseIdentifier) as? TextViewTableViewCell else { return UITableViewCell() }
                
                cell.setPlaceholder(tableViewSectionTitle[indexPath.section][indexPath.row])
                cell.backgroundColor = TodoColor.cellBackgroundColor
                cell.delegate = self
                cell.selectionStyle = .none
                
                return cell
            }
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.reuseIdentifier) as? LabelTableViewCell else { return UITableViewCell() }
            
            cell.setTitle(tableViewSectionTitle[indexPath.section][indexPath.row])
            cell.backgroundColor = TodoColor.cellBackgroundColor
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc = DueDateViewController()
            
            vc.saveDueDate = { value in
                if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? LabelTableViewCell {
                    cell.setContent(value.toString(.ymd))
                }
                self.viewModel.saveDueDate(value)
            }
            
            self.navigationController?.pushViewController(vc, animated: false)
        case 2:
            let vc = TagViewController()
            
            vc.saveTag = { [weak self] value in
                if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? LabelTableViewCell {
                    if let value {
                        cell.setContent("# \(value)")
                        self?.viewModel.saveTag(value)
                    }
                }
                
            }
            
            self.navigationController?.pushViewController(vc, animated: false)
        case 3:
            let vc = PriorityViewController()
   
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(priorityReceivedNotification),
                name: NSNotification.Name("priorityReceived"),
                object: nil)
            
            self.navigationController?.pushViewController(vc, animated: false)
        default:
            break
            
        }
    }
    
    @objc
    private func priorityReceivedNotification(notification: Notification) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? LabelTableViewCell {
            if let result = notification.userInfo?["priority"] as? Int {
                cell.setContent(TodoPriority.allCases[result].rawValue)
                self.viewModel.savePriority(result)
            }
        }
    }
    
}


extension AddNewTodoViewController: TransferTableViewCellDataDelegate {
    
    func textFieldValueDidChange(value: String?) {
        viewModel.saveTitle(value)
    }
    
    func textViewValueDidChange(value: String?) {
        viewModel.saveContent(value)
    }
    
}
