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
    var similarData: TrendResponse?
    var recommendData: TrendResponse?

    private let tableView = UITableView()

    
    let tableViewSectionTitle: [String] = ["OverView", "Cast"]
    let collectionViewSectionTitle = ["비슷한 영화, 드라마", "추천 영화, 드라마"]
    
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

        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        
        TMDBNetworkManager.shared.getData(url: .tmdbCredit("\(trendData.id)"), reponseType: CreditType.self) { response in
            self.castData = response
            self.tableView.reloadSections(IndexSet(0...1), with: .automatic)
        }
        TMDBNetworkManager.shared.getData(url: .tmdbSimilar("\(trendData.id)"), reponseType: TrendResponse.self) { response in
            self.similarData = response
            self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
        TMDBNetworkManager.shared.getData(url: .tmdbRecommend("\(trendData.id)"), reponseType: TrendResponse.self) { response in
            self.recommendData = response
            self.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
        }
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
        tableView.register(AdditionalMovieImageTableViewCell.self, forCellReuseIdentifier: AdditionalMovieImageTableViewCell.identifier)
    }
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewSectionTitle.count + collectionViewSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0,1:
            return tableViewSectionTitle[section]
        case 2,3:
            return collectionViewSectionTitle[section - 2]
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let castData, let cast = castData.cast {
                return cast.count
            }
            return 0
        case 2:
            if let similarData {
                return 1
            }
            return 0
        case 3:
            if let recommendData {
                return 1
            }
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.setContents(trendData.overview)
            
            return cell
        } else if indexPath.section == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            if let castData,
               let cast = castData.cast {
                cell.setContents(cast[indexPath.row])
            }
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalMovieImageTableViewCell.identifier, for: indexPath) as? AdditionalMovieImageTableViewCell else { return UITableViewCell() }
            
            if let similarData {
                cell.data = similarData
            }
            
            return cell
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalMovieImageTableViewCell.identifier, for: indexPath) as? AdditionalMovieImageTableViewCell else { return UITableViewCell() }
            
            if let recommendData {
                cell.data = recommendData
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
  
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tableViewCell = cell as? AdditionalMovieImageTableViewCell {
            tableViewCell.reloadCollectionView()
        }
    }
    
    
}
