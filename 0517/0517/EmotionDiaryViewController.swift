//
//  EmotionDiaryViewController.swift
//  0517
//
//  Created by 김수경 on 5/18/24.
//

import UIKit

class EmotionDiaryViewController: UIViewController {
    
    @IBOutlet var hamburgerBarButton: UIBarButtonItem!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var labels: [UILabel]!
    
    
    let labelText = ["행복해", "사랑해", "힘들어", "배고파", "배불러", "아싸!", "기뻐!", "심심해", "우울해"]
//    var labelStatus = Array(repeating: 0, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarItemUISetting()
        buttonUISetting()
        labelUISetting()
        
    }
    
    func navigationBarItemUISetting() {
        hamburgerBarButton.image = UIImage(systemName: "line.3.horizontal")
    }
    
    func buttonUISetting() {
        for button in buttons {
            button.setImage(UIImage(named: "slime\(button.tag + 1)"), for: .normal)
        }
    }
    
    func labelUISetting() {
        for label in labels {
            let count = UserDefaults.standard.integer(forKey: "\(label.tag)")
            
            label.text = "\(labelText[label.tag]) \(count)"
            label.textAlignment = .center
        }
    }
    
    @IBAction func slimeButtonTapped(_ sender: UIButton) {
        let count = UserDefaults.standard.integer(forKey: "\(sender.tag)") + 1
        UserDefaults.standard.setValue(count, forKey: "\(sender.tag)")
        
        labels[sender.tag].text = "\(labelText[sender.tag]) \(count)"
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        for i in 0..<9 {
            UserDefaults.standard.setValue(0, forKey: "\(i)")
        }
        labelUISetting()
    }
}
