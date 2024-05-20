//
//  NetflixViewController.swift
//  0517
//
//  Created by 김수경 on 5/20/24.
//

import UIKit

class NetflixViewController: UIViewController {
    
    @IBOutlet var titleNavigationItem: UINavigationItem!
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var miniPosterImageView: [UIImageView]!
    @IBOutlet var badgeImageView: [UIImageView]!

    @IBOutlet var newEpisodeLabel: [UILabel]!
    @IBOutlet var watchNowLabel: [UILabel]!
    
    let movieName: [String] = ["고려거란전쟁","구미호뎐","노량","더퍼스트슬램덩크","마스크걸","무빙","밀수","범죄도시3","비질란테","서울의봄","소년시대","수리남","스즈메의문단속","아바타물의길","오펜하이머","육사오","이두나","카지노","콘크리트유토피아","택배기사"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemSetting()
        posterImageSetting()
        setNewContentsLabel()
    }

    
    @IBAction func randomImageButtonTapped(_ sender: UIButton) {
        let randomIndex = Array(0..<movieName.count).shuffled()
        
        posterImageView.image = UIImage(named: movieName[randomIndex[0]])
        for i in 0..<miniPosterImageView.count {
            miniPosterImageView[i].image = UIImage(named: movieName[randomIndex[i+1]])
        }
        
        let randomBadge = Int.random(in: 0...2)
        for i in 0...2 {
            if randomBadge == i {
                badgeImageView[i].isHidden = false
                newEpisodeLabel[i].isHidden = false
                watchNowLabel[i].isHidden = false
            } else {
                badgeImageView[i].isHidden = true
                newEpisodeLabel[i].isHidden = true
                watchNowLabel[i].isHidden = true
            }
        }
        
    }
    
    private func setNavigationItemSetting() {
        titleNavigationItem.title = "고래밥님"
    }
    
    private func posterImageSetting() {
        for i in 0..<miniPosterImageView.count {
            miniPosterImageView[i].layer.cornerRadius = 10
        }
        posterImageView.layer.cornerRadius = 10
    }
    
    private func setNewContentsLabel() {
        for label in newEpisodeLabel {
            label.isHidden = true
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 8)
        }
        for label in watchNowLabel {
            label.isHidden = true
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 8)
        }
        for i in 0..<3 {
            newEpisodeLabel[i].backgroundColor = .white
            newEpisodeLabel[i].tintColor = .red
            newEpisodeLabel[i].text = "새로운 에피소드"
            watchNowLabel[i].backgroundColor = .red
            watchNowLabel[i].tintColor = .white
            watchNowLabel[i].text = "지금 시청하기"
        }
    }
    
}
