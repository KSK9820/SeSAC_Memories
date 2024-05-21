//
//  ViewController.swift
//  0521
//
//  Created by 김수경 on 5/21/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var characterImageView: UIImageView!
    
    @IBOutlet var roundedHeightView: UIView!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var cautionHeightLabel: UILabel!
    
    @IBOutlet var roundedWeightView: UIView!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var cautionWeightLabel: UILabel!
    
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUI()
    }


    private func setUI() {
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        subTitleLabel.numberOfLines = 0
        subTitleLabel.text = "당신의 BMI 지수를\n알려드릴게요"
        subTitleLabel.font = .systemFont(ofSize: 20)
        subTitleLabel.textAlignment = .left
        
        characterImageView.image = UIImage.image
        characterImageView.contentMode = .scaleAspectFit
        
        
        roundedHeightView.layer.cornerRadius = 18
        roundedHeightView.layer.borderWidth = 2
        roundedHeightView.layer.borderColor = UIColor.black.cgColor
        heightTextField.borderStyle = .none
        heightTextField.font = .systemFont(ofSize: 20)
        cautionHeightLabel.textColor = .darkGray
        cautionHeightLabel.isHidden = true
        cautionHeightLabel.font = .systemFont(ofSize: 12)
        
        roundedWeightView.layer.cornerRadius = 18
        roundedWeightView.layer.borderWidth = 2
        roundedWeightView.layer.borderColor = UIColor.black.cgColor
        weightTextField.font = .systemFont(ofSize: 20)
        weightTextField.borderStyle = .none
        cautionWeightLabel.textColor = .darkGray
        cautionWeightLabel.isHidden = true
        cautionWeightLabel.font = .systemFont(ofSize: 12)
        
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.setTitleColor(.red, for: .normal)
        
        
        resultButton.setTitle("결과 확인하기", for: .normal)
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.backgroundColor = .systemPurple
        resultButton.layer.cornerRadius = 20
    }
    
    private func checkHeightValidity() -> Bool  {
        guard let height = heightTextField.text else { return false }

        
        
        return true
    }
    
    
    // Editing Change
    @IBAction func checkValidateHeight(_ sender: UITextField) {

        guard let input = sender.text else { return }
        guard let height = Int(input) else {
            cautionHeightLabel.isHidden = false
            cautionHeightLabel.text = "숫자만 입력해주세요"
            return
        }
        if height < 50 || height > 250 {
            cautionHeightLabel.isHidden = false
            cautionHeightLabel.text = "50 ~ 250 사이의 값을 입력해주세요"
            return
        }
        
        cautionHeightLabel.isHidden = true
    }
    
    @IBAction func checkValidateWeight(_ sender: UITextField) {
        guard let input = sender.text else { return }
        guard let weight = Int(input) else {
            cautionWeightLabel.isHidden = false
            cautionWeightLabel.text = "숫자만 입력해주세요"
            return
        }
        if weight < 20 || weight > 200 {
            cautionWeightLabel.isHidden = false
            cautionWeightLabel.text = "20 ~ 200 사이의 값을 입력해주세요"
            return
        }
        
        cautionWeightLabel.isHidden = true
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        guard let height = (50...250).randomElement() else { return }
        guard let weight = (20...200).randomElement() else { return }

        let bmi = String(format: "%.2f", Double(weight) / pow(Double(height) * 0.01, 2))

        showAlert(height: height, weight: weight, bmi: bmi)
    }
    
    private func setBodyFatStatus(bmi: Double) -> String {
        var status = ""
        
        if bmi < 18.5 {
            status = "저체중"
        } else if bmi < 23 {
            status = "정상"
        } else if bmi < 25 {
            status = "과체중"
        } else {
            status = "비만"
        }
        
        return status
    }
    
    private func showAlert(height: Int, weight: Int, bmi: String) {
        guard let bmi = Double(bmi) else { return }
        let alert = UIAlertController(
            title: setBodyFatStatus(bmi: bmi),
            message: "키: \(height) 몸무게: \(weight) bmi: \(bmi)입니다.",
            preferredStyle: .alert)
        
        let ok = UIAlertAction(
            title: "확인",
            style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        
        if !cautionHeightLabel.isHidden || !cautionWeightLabel.isHidden {
            return
        }
        guard let hInput = heightTextField.text,
              let height = Int(hInput)
        else { return }
        
        guard let wInput = weightTextField.text,
              let weight = Int(wInput)
        else { return }
        
        let bmi = String(format: "%.2f", Double(weight) / pow(Double(height) * 0.01, 2))
        showAlert(height: height, weight: weight, bmi: bmi)
    }
}

