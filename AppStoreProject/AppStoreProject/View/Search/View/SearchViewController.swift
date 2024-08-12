//
//  SearchViewController.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    private let searchController = UISearchController().then {
        $0.obscuresBackgroundDuringPresentation = false
    }
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionView())
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.scrollEdgeAppearance = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureUI()
        bind()
    }
    
    private func bind() {
        let input = SearchViewModel.Input(
            searchText: searchController.searchBar.rx.text.orEmpty,
            searchButtonTap: searchController.searchBar.rx.searchButtonClicked,
            collectionViewItemTap: collectionView.rx.itemSelected
        )
        let output = viewModel.transform(input)
        
        output.searchResult
            .bind(to: collectionView.rx.items(cellIdentifier: SearchCollectionViewCell.reuseIdentifier, cellType: SearchCollectionViewCell.self)) { (row, element, cell) in
                
                cell.setContents(element)
            }
            .disposed(by: disposeBag)
        
        
        output.collectionViewItemTap
            .withLatestFrom(output.tapResult, resultSelector: { _, value in
                return value
            })
            .asObservable()
            .bind(with: self) { owner, value in
                let vm = DetailViewModel(value)
                let vc = DetailViewController(vm)
                
                owner.navigationController?.pushViewController(vc, animated: false)
            }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        configureNavigation()
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
    }
    
    private func configureNavigation() {
        navigationItem.title = "검색"
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "게임, 앱, 스토리 등"
        navigationItem.largeTitleDisplayMode = .always
        
        guard let navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
}
