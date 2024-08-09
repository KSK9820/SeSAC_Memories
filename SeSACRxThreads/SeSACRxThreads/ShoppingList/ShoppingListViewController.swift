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
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(ShoppingListCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingListCollectionViewCell.reuseIdentifier)
        $0.showsHorizontalScrollIndicator = false
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
    
    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func bind() {
        let input = ShoppingListViewModel.Input(
            addButtonTap: addButton.rx.tap,
            addText: searchTextField.rx.text.orEmpty,
            searchText: searchTextField.rx.text.orEmpty
                .debounce(.seconds(1), scheduler: MainScheduler.instance)
                .distinctUntilChanged(),
            selectItem: collectionView.rx.modelSelected(String.self),
            checkButtonTap: PublishSubject<Int>(),
            starButtonTap: PublishSubject<Int>()
        )
        let output = viewModel.transform(input: input)
    
        output.selectList
            .bind(to: collectionView.rx.items(cellIdentifier: ShoppingListCollectionViewCell.reuseIdentifier, cellType: ShoppingListCollectionViewCell.self)) { (row, element, cell) in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
          
        
        
        output.shoppingList
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.reuseIdentifier, cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
                
                cell.setContents(element)
                cell.checkboxButton.rx.tap
                    .bind(with: self) { owner, _ in
                        input.checkButtonTap.onNext(row)
                    }
                    .disposed(by: cell.disposeBag)
                cell.starButton.rx.tap
                    .bind(with: self) { owner, _ in
                        input.starButtonTap.onNext(row)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    
        output.addButtonTap
            .map { "" }
            .bind(to: searchTextField.rx.text)
            .disposed(by: disposeBag)

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
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        searchView.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(10)
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
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea).inset(20)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
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
