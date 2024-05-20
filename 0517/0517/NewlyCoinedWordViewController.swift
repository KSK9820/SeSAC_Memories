//
//  NewlyCoinedWordViewController.swift
//  0517
//
//  Created by 김수경 on 5/18/24.
//

import UIKit

class NewlyCoinedWordViewController: UIViewController {

    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    
    @IBOutlet var labelStack: UIStackView!
    @IBOutlet var labelView: [UIView]!
    @IBOutlet var randomWordLabel: [UILabel]!
    @IBOutlet var meaningLabel: UILabel!
    
    
    let coinWords = ["쫌쫌따리", "억텐", "스불재", "좋댓구알", "어쩔티비", "갓생", "점메추", "다꾸", "뇌꾸", "킹받다", "군싹"]
    let mean = ["조금씩 조금씩 차곡차곡 모으거나 쌓아가는 것", "부자연스럽게 높은 텐션을 보이는 상태", "스스로 불러온 재앙", "좋아요, 댓글, 구독, 알림설정", "상대방의 말에 대해 관심 없음을 표현하는 말", "매우 멋있거나 완벽한 생활", "점심 메뉴 추천", "다이어리를 예쁘게 꾸미는 활동", "새로운 지식을 배워 뇌를 발전시키는 것", "매우 화가 나다", "음식을 보거나 생각만 해도 군침이 도는 상태"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewSetting()
        labelUISetting()
    }

    
    @IBAction func searchWord(_ sender: UIButton) {
        setRandomLabel()
        setMeaningLabel()
    }
    
    @IBAction func finishEditing(_ sender: UITextField) {
        setRandomLabel()
        setMeaningLabel()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    func labelUISetting() {
        for view in labelView {
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 8
            view.isHidden = true
        }
        
        for label in randomWordLabel {
            label.textAlignment = .center
            label.font = .preferredFont(forTextStyle: .body)
        }
        
        labelStack.distribution = .fill
    }
    
    func searchViewSetting() {
        searchView.layer.borderColor = UIColor.black.cgColor
        searchView.layer.borderWidth = 3
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .black
    }
    
    func setRandomLabel() {
        let randomIndex = Array(0..<coinWords.count).shuffled()
    
        for label in randomWordLabel {
            labelView[label.tag].isHidden = false
            label.text = coinWords[randomIndex[label.tag]]
        }
    }
    
    func setMeaningLabel() {
        var index = -1
        
        for i in 0..<coinWords.count {
            if coinWords[i] == searchTextField.text {
                index = i
            }
        }
        
        meaningLabel.text = index == -1 ? "일치하는 단어가 없습니다." : mean[index]
    }
    
}
