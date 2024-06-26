//
//  SearchViewController.swift
//  0604
//
//  Created by 김수경 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire


final class SearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    var data: TrendResponse?
    var page = 1
    var currentSearchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3 * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
    
    private func getData() {
        let url = APIURL.tmdbSearch.urlString
        guard let currentSearchText else { return }
        let parameter: Parameters = ["query": currentSearchText, "page": page]
        let header: HTTPHeaders = [
            "Authorization" : APIKey.tmdb.apikey,
            "access" : "application/json"
        ]
        
        AF.request(url, parameters: parameter, headers: header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let data):
                if self.page == 1 {
                    self.data = data
                    self.collectionView.reloadData()
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                } else {
                    self.data?.page = data.page
                    self.data?.results.append(contentsOf: data.results)
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if checkSearchText() {
            page = 1
            currentSearchText = searchBar.text
            getData()
        }
    }
    
    private func checkSearchText() -> Bool {
        guard let searchText = searchBar.text else { return false }
        if searchText.trimmingCharacters(in: .whitespaces) == "" { return false }
        
        return true
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data {
            return data.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let data {
            cell.setContents(data.results[indexPath.row])
        }
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let data = data else { return }
        
        for indexPath in indexPaths {
            if indexPath.row == data.results.count - 4 && page < data.total_pages {
                page += 1
                getData()
            }
        }
    }
}
