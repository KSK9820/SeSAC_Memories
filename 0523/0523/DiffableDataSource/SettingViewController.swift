//
//  SettingViewController.swift
//  0523
//
//  Created by 김수경 on 7/18/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    private let viewModel = SettingViewModel()
    
    private var settingDataSource: SettingDataSource?
    private lazy var settingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureDataSource()
        applySnapshot()
    }
    
    
    // MARK: - Configure UI
        
    private func configureHierarchy() {
        view.addSubview(settingCollectionView)
    }
    
    private func configureLayout() {
        settingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .white
        config.headerMode = .supplementary
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
}


// MARK: - UICollectionView Diffable DataSource

extension SettingViewController {
    
    private typealias SettingDataSource = UICollectionViewDiffableDataSource<SettingSection, SettingItem>
    private typealias SettingCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SettingItem>
    private typealias SettingHeaderRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>
    
    private func configureDataSource() {
        let headerRegistration = SettingHeaderRegistration(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            
            var content = UIListContentConfiguration.groupedHeader()
            content.text = SettingSection.allCases[indexPath.section].rawValue
            content.textProperties.color = .black
            content.textProperties.font = .boldSystemFont(ofSize: 17)
            supplementaryView.contentConfiguration = content
        }
        
        let cellRegistration = SettingCellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.textProperties.color = .darkGray
            content.textProperties.font = .systemFont(ofSize: 15)
        
            cell.contentConfiguration = content
        }
        
        
        settingDataSource = SettingDataSource(collectionView: settingCollectionView,
                                              cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        settingDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        settingDataSource?.supplementaryViewProvider
        
        
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SettingSection, SettingItem>()
        snapshot.appendSections(SettingSection.allCases)
        for i in  SettingSection.allCases.indices {
            snapshot.appendItems(viewModel.settingItems[i], toSection: SettingSection.allCases[i])
        }
        settingDataSource?.apply(snapshot)
    }
    
}


enum SettingSection: String, CaseIterable {
    case all = "전체 설정"
    case personal = "개인 설정"
    case etc = "기타"
}

struct SettingItem: Hashable, Identifiable {
    let id: UUID = UUID()
    let title: String
}
