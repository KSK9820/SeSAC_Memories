//
//  SaveContentViewController.swift
//  0517
//
//  Created by 김수경 on 5/20/24.
//

import UIKit

class SaveContentsViewController: UIViewController {
    
    @IBOutlet var navigationItemBar: UINavigationItem!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        navigationItemBar.title = "저장한 콘텐츠"
        
        firstLabel.text = "'나만의 자동 저장' 기능"
        firstLabel.font = .systemFont(ofSize: 22, weight: .bold)
        firstLabel.textAlignment = .center
       
        
        secondLabel.text = "취향에 맞는 영화와 시리즈를 자동으로 저장해 드립니다. 디바이스에 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요."
        secondLabel.numberOfLines = 0
        
        secondLabel.textAlignment = .center
        
        imageView.image = UIImage.dummy
        
        firstButton.setTitle("설정하기", for: .normal)
        firstButton.backgroundColor = .blue
        firstButton.tintColor = .white
        firstButton.layer.cornerRadius = 10
        
        
        secondButton.setTitle("저장 가능한 콘텐츠 살펴보기", for: .normal)
        secondButton.backgroundColor = .black
        secondButton.tintColor = .white
        secondButton.layer.cornerRadius = 10
    }
}
