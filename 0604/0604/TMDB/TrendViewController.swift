//
//  TrendViewController.swift
//  0604
//
//  Created by 김수경 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

final class TrendViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var trendData: TrendResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        tableView.separatorStyle = .none
    }

    
    
    // MARK: - network

    private func getData() {
        let url = APIURL.tmdb(.day).urlString
        let header: HTTPHeaders = [
            "Authorization" : APIKey.tmdb.apikey,
            "access" : "application/json"
        ]

        AF.request(url, headers: header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.trendData = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension TrendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trendData {
            return trendData.results.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as? TrendTableViewCell else { return UITableViewCell() }
        
        if let data = trendData?.results[indexPath.row] {
            cell.setContents(data)
        }
        
        return cell
    }
}

extension TrendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.layer.frame.width + 50
    }
}
