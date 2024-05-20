//
//  SearchViewController.swift
//  0517
//
//  Created by 김수경 on 5/20/24.
//


import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var buttonStackView: UIStackView!

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setButtonUI()
    }

    @IBAction func tappedFirstButton(_ sender: UIButton) {
        
        firstButton.tintColor = .gray
        secondButton.tintColor = .black
        thirdButton.tintColor = .black
        
        firstLabel.text = "이런! 찾으시는 영화가 없습니다."
        secondLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해보세요"
    }
    
    @IBAction func tappedSecondButton(_ sender: UIButton) {
        
        firstButton.tintColor = .black
        secondButton.tintColor = .gray
        thirdButton.tintColor = .black
        
        firstLabel.text = "모두의 인기 콘텐츠"
        secondLabel.text = "를 선택하였습니다."
    }
    
    @IBAction func tappedThridButton(_ sender: UIButton) {
        firstButton.tintColor = .black
        secondButton.tintColor = .black
        thirdButton.tintColor = .gray
        
        firstLabel.text = "TOP 10 시리즈"
        secondLabel.text = "를 선택하였습니다."
    }
    
    private func setButtonUI() {
        firstButton.setTitle("공개 예정", for: .normal)
        firstButton.titleLabel?.font = .systemFont(ofSize: 9)
        firstButton.tintColor = .gray
        firstButton.setImage(UIImage(named: "turquoise"), for: .normal)
        firstButton.configuration = .filled()
        firstButton.configuration?.cornerStyle = .capsule
        firstButton.configuration?.baseForegroundColor = .lightGray
        

        secondButton.setTitle("인기 콘텐츠", for: .normal)
        secondButton.titleLabel?.font = .systemFont(ofSize: 9)
        secondButton.tintColor = .black
        secondButton.setImage(UIImage(named: "pink"), for: .normal)
        secondButton.configuration = .filled()
        secondButton.configuration?.cornerStyle = .capsule
        
        
        thirdButton.setTitle("TOP 10", for: .normal)
        thirdButton.titleLabel?.font = .systemFont(ofSize: 9)
        thirdButton.tintColor = .black
        thirdButton.setImage(UIImage(named: "blue"), for: .normal)
        thirdButton.configuration = .filled()
        thirdButton.configuration?.cornerStyle = .capsule
        
        firstLabel.font = .systemFont(ofSize: 22, weight: .bold)
        secondLabel.font = .systemFont(ofSize: 18)
        firstLabel.text = "이런! 찾으시는 영화가 없습니다."
        secondLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해보세요"
    }
    
    func setUI() {
        navigationBar.title = "NEW & HOT 검색"
        
        searchTextField.placeholder = "게임, 시리즈, 영화를 검색하세요..."
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        buttonStackView.spacing = 8
    }
}
