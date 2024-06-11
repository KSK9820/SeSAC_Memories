//
//  CreditViewController.swift
//  0604
//
//  Created by 김수경 on 6/11/24.
//

import UIKit
import Alamofire
import SnapKit

final class CreditViewController: UIViewController {
    
    let trendData: Result
    var castData: CreditType?

    private let tableView = UITableView()
    
    let tableViewSectionTitle: [String] = ["OverView", "Cast"]
    
    // MARK: - Initialize
    
    init(trendData: Result) {
        self.trendData = trendData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    
    // MARK: - UI Configure
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let vc = CreditHeaderView(data: trendData)
        vc.frame = CGRect(x: 0, y: 0, width: view.layer.frame.width, height: view.layer.frame.height * 0.25)
        tableView.tableHeaderView = vc
    
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
    }
    
    
    private func getData() {
        let url = APIURL.tmdbCredit("\(trendData.id)").urlString
        let header: HTTPHeaders = [
            "Authorization" : APIKey.tmdb.apikey,
            "access" : "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: CreditType.self) { response in
            switch response.result {
            case .success(let data):
                self.castData = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let castData, let cast = castData.cast {
                return cast.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.setContents(trendData.overview)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            if let castData,
               let cast = castData.cast {
                cell.setContents(cast[indexPath.row])
            }
            
            return cell
        }
    }

    
}

