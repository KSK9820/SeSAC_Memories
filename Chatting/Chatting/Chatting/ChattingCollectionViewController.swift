//
//  ChattingCollectionViewController.swift
//  Chatting
//
//  Created by 김수경 on 7/19/24.
//

import UIKit
import SnapKit


final class ChattingCollectionViewController: UIViewController {

    private var chattingDataSource: ChattingDataSource?
    
    private var chattingList: [ChatRoom] = mockChatList {
        didSet {
            applySnapshot()
        }
    }
    
    private var searchController = UISearchController()
    private lazy var chattingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureDataSource()
        applySnapshot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = false
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(chattingCollectionView)
    }
    
    private func configureLayout() {
        chattingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        chattingCollectionView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "친구의 이름을 검색해보세요"
        searchController.searchBar.searchBarStyle = .default
        searchController.obscuresBackgroundDuringPresentation = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .lightGray
            textField.textColor = .darkGray
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "TRAVEL TALK"
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .white
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
}


// MARK: - Diffable DataSource

extension ChattingCollectionViewController {
    
    private typealias ChattingDataSource = UICollectionViewDiffableDataSource<Section, ChatRoom>
    private typealias ChattingCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>
    
    private func configureDataSource() {
        let cellRegistration = ChattingCellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.chatroomName
            
            if let lastMessage = itemIdentifier.chatList.last?.message {
                content.secondaryText = lastMessage
                content.textToSecondaryTextVerticalPadding = 4
                content.prefersSideBySideTextAndSecondaryText = false
            }
            
            
            if let chatroomImage = itemIdentifier.chatroomImage.first {
                content.image = UIImage(named: chatroomImage)
                content.imageProperties.maximumSize = .init(width: cell.frame.height, height: cell.frame.height)
                content.imageProperties.reservedLayoutSize = .init(width: cell.frame.height, height: cell.frame.height)
                content.imageToTextPadding = 20
            }
            
            cell.contentConfiguration = content
        }
        
        chattingDataSource = ChattingDataSource(collectionView: chattingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatRoom>()
        snapshot.appendSections([.main])
        snapshot.appendItems(chattingList, toSection: .main)
        
        chattingDataSource?.apply(snapshot)
    }
    
}

extension ChattingCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: ChatViewController.identifier) as? ChatViewController else { return }
        vc.item = chattingList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ChattingCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            chattingList = mockChatList.filter { $0.chatroomName.contains(searchText) }
        } else {
            chattingList = mockChatList
        }
    }
}



enum Section: CaseIterable {
    case main
}



