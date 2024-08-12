//
//  BoxOfficeCollectionViewCell.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/9/24.
//

import UIKit
import RxSwift

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel().then {
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
      
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
