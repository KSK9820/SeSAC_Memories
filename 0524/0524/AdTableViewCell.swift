//
//  AdTableViewCell.swift
//  0524
//
//  Created by 김수경 on 5/28/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var adView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    
    let randomColor: [UIColor] = [.red, .blue, .green, .systemPink, .brown, .orange, .brown, .yellow]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }

    private func setUI() {
        adView.backgroundColor = randomColor.randomElement()
        adView.layer.cornerRadius = 12
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        adLabel.backgroundColor = .white
        adLabel.layer.cornerRadius = 8
        adLabel.font = .systemFont(ofSize: 12)
    }
    
    func setContext(_ data: Travel) {
        titleLabel.text = data.title
    }
    
}
