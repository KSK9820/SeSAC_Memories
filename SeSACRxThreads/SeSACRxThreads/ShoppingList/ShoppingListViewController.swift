//
//  ShoppingListViewController.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/3/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ShoppingListViewController: UIViewController {
    
    private let viewModel = ShoppingListViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let searchView = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 10
    }
    private let searchTextField = UITextField().then {
        $0.placeholder = "무엇을 구매하실 건가요?"
    }
    private let addButton = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.backgroundColor = .lightGray.withAlphaComponent(0.3)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 10
    }
    private let tableView = UITableView().then {
        $0.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none
        $0.rowHeight = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        bind()
    }
    
    private func bind() {
        let input = ShoppingListViewModel.Input(
            addButtonTap: addButton.rx.tap,
            addText: searchTextField.rx.text.orEmpty,
            searchText: searchTextField.rx.text.orEmpty
                .debounce(.seconds(1), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
        )
        let output = viewModel.transform(input: input)
    
        output.shoppingList
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.reuseIdentifier, cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
                
                cell.setContents(element)
            }
            .disposed(by: disposeBag)
    
        output.addButtonTap
            .map { "" }
            .bind(to: searchTextField.rx.text)
            .disposed(by: disposeBag)
//
//                cellOutput.shoppingList
//                    .bind(with: self) { onwer, value in
//                        cell.toggleCheckbox(value.done)
//                    }
//                    .disposed(by: cell.disposeBag)
//                cell.checkboxButton.rx.tap
//                    .bind(with: self) { owner, _ in
//                        owner.data[row].done.toggle()
//                        cell.toggleCheckbox(owner.data[row].done)
//                        owner.list.onNext(owner.data)
//                    }
//                    .disposed(by: cell.disposeBag)
//                
//                cell.starButton.rx.tap
//                    .bind(with: self) { owner, _ in
//                        owner.data[row].star.toggle()
//                        owner.data = owner.data.sorted { $0.date < $1.date }.sorted { $0.star && !$1.star }
//                        cell.toggleCheckbox(owner.data[row].star)
//                        owner.list.onNext(owner.data)
//                    }
//                    .disposed(by: cell.disposeBag)
//            }
//            .disposed(by: disposeBag)
//        

        
        tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                owner.navigationController?.pushViewController(UIViewController(), animated: false)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(searchView)
        [searchTextField, addButton].forEach {
            searchView.addSubview($0)
        }
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        searchView.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(30)
            make.horizontalEdges.equalTo(safeArea).inset(20)
            make.height.equalTo(70)
        }
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea).inset(20)
            make.bottom.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "쇼핑"
    }
    
}


struct ShoppingList {
    let date: Date = Date()
    let title: String
    var star: Bool = false
    var done: Bool = false
}
