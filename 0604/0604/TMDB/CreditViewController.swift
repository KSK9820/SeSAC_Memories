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
    let tableViewSectionTitle: [String] = ["OverView", "Cast", "비슷한 영화, 드라마", "추천 영화, 드라마"]
    
    private let tableView = UITableView()

    
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
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) { [weak self] in
            guard let id = self?.trendData.id else { group.leave(); return }
            TMDBNetworkManager.shared.getData(url: .tmdbCredit("\(id)"), reponseType: CreditType.self) { response in
                self?.castData = response
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { [weak self] in
            guard let id = self?.trendData.id else { group.leave(); return }
            TMDBNetworkManager.shared.getData(url: .tmdbSimilar("\(id)"), reponseType: TrendResponse.self) { response in
                self?.similarData = response
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { [weak self] in
            guard let id = self?.trendData.id else { group.leave(); return }
            TMDBNetworkManager.shared.getData(url: .tmdbRecommend("\(id)"), reponseType: TrendResponse.self) { response in
                self?.recommendData = response
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
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
        tableViewSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSectionTitle[section]
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
            return similarData != nil ? 1 : 0
        case 3:
            return recommendData != nil ? 1 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.setContents(trendData.overview)
            
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            if let castData,
               let cast = castData.cast {
                cell.setContents(cast[indexPath.row])
            }
            
            return cell
        }
        
        if indexPath.section == 2 || indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalMovieImageTableViewCell.identifier, for: indexPath) as? AdditionalMovieImageTableViewCell else { return UITableViewCell() }
            
            cell.collectionView.dataSource = self
            cell.collectionView.register(ContentImageCollectionViewCell.self, forCellWithReuseIdentifier: ContentImageCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.section
            cell.collectionView.reloadData()
            
            return cell
        }
        
        return UITableViewCell()
    }

}


extension CreditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 2:
            return similarData == nil ? 0 : similarData!.results.count
        case 3:
            return recommendData == nil ? 0 : recommendData!.results.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentImageCollectionViewCell.identifier, for: indexPath) as? ContentImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if collectionView.tag == 2 {
            guard let similarData = similarData?.results else { return UICollectionViewCell() }
            cell.setImage(similarData[indexPath.row])
        } else if collectionView.tag == 3 {
            guard let recommendData = recommendData?.results else { return UICollectionViewCell() }
            cell.setImage(recommendData[indexPath.row])
        }
        
        return cell
    }
}
