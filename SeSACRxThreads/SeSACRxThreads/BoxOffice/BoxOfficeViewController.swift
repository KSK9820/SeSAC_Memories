//
//  BoxOfficeViewController.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/9/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BoxOfficeViewController: UIViewController {
    
    let viewModel = BoxOfficeViewModel()
    
    let searchBar = UISearchBar()
    let tableView = UITableView().then {
        $0.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.reuseIdentifier)
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ShoppingListViewController.createLayout()).then {
        $0.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.reuseIdentifier)
    }
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        bind()
    }
    
    private func bind() {
        let selectedMovie = PublishSubject<String>()
        let input = BoxOfficeViewModel.Input(searchText: searchBar.rx.text.orEmpty, searchButtonTap: searchBar.rx.searchButtonClicked, selectedText: selectedMovie)
        let output = viewModel.transform(input: input)
        
        output.movieList
            .bind(to: tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.reuseIdentifier, cellType: BoxOfficeTableViewCell.self)) { (row, element, cell) in
                
                cell.movieRank.text = element.rank
                cell.movieName.text = element.movieNm
                cell.movieDate.text = element.openDt

            }
            .disposed(by: disposeBag)
        
        output.recentList
            .bind(to: collectionView.rx.items(cellIdentifier: BoxOfficeCollectionViewCell.reuseIdentifier, cellType: BoxOfficeCollectionViewCell.self)) { (row, element, cell) in
                
                cell.label.text = element
            }
            .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.modelSelected(DailyBoxOfficeList.self), tableView.rx.itemSelected)
            .map { "\($0.1.row):  \($0.0.movieNm)" }
            .subscribe(with: self) { onwer, value in
                selectedMovie.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        navigationItem.titleView = searchBar
        
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }

}
