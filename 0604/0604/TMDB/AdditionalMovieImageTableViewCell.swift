//
//  AdditionalMovieImageTableViewCell.swift
//  0604
//
//  Created by 김수경 on 6/24/24.
//

import UIKit
import SnapKit
import Kingfisher

final class AdditionalMovieImageTableViewCell: UITableViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal Method

    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            let height = UIScreen.main.bounds.width / 3 * 1.5 + 20
            make.height.equalTo(height)
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = Int(UIScreen.main.bounds.width)
        layout.itemSize = CGSize(width: width / 3, height: Int(Double(width / 3) * 1.5))
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return layout
    }
}
