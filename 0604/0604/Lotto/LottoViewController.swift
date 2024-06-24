//
//  LottoViewController.swift
//  0604
//
//  Created by 김수경 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit

final class LottoViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.textAlignment = .center
        view.inputView = numberPicker
        
        return view
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        
        return label
    }()
    
    private let boundaryView: UIView =  {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 32)
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 4
        
        return view
    }()
    
    private let numberLabels: [InsetLabel] = [InsetLabel(), InsetLabel(), InsetLabel(), InsetLabel(), InsetLabel(), InsetLabel(), InsetLabel(), InsetLabel()]
    
    private let bonusLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .gray
        label.text = "보너스"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var numberPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
    
    
    // MARK: - initialize
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        NetworkManager.shared.getLotto("986") { data, numbers in
            self.configureLottoUI(numbers)
            self.textField.text = "\(data.drwNo)"
            self.setTitleLabel()
            self.dateLabel.text = data.drwNoDate
        }
        configurePikcer()
        
    }
    
    
    private func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(informationLabel)
        view.addSubview(dateLabel)
        view.addSubview(boundaryView)
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        numberLabels.forEach { label in
            stackView.addArrangedSubview(label)
        }
        view.addSubview(bonusLabel)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeArea).inset(30)
            make.height.equalTo(50)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.leading.equalTo(safeArea).offset(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.trailing.equalTo(safeArea).offset(-30)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeArea).inset(30)
            make.height.equalTo(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(boundaryView.snp.bottom).offset(40)
            make.centerX.equalTo(safeArea)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeArea).inset(10)
        }
        
        stackView.arrangedSubviews.forEach { view in
            view.snp.makeConstraints { make in
                make.size.equalTo(view.snp.width)
            }
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.trailing.equalTo(safeArea).offset(-10)
        }
        
    }
    
    private func configurePikcer() {
        numberPicker.delegate = self
        numberPicker.dataSource = self
    }
    
    
    private func configureLottoUI(_ numbers: [String]) {
        stackView.arrangedSubviews.enumerated().forEach { index, view in
            if let label = view as? UILabel {
                
                guard let number = Int(numbers[index]) else {
                    label.backgroundColor = .white
                    label.textColor = .black
                    label.text = "+"
                    
                    return
                }
                
                label.text = "\(numbers[index])"
                label.layer.opacity = 0.7
                
                switch number {
                case 0...9:
                    label.backgroundColor = .systemYellow
                case 10...19:
                    label.backgroundColor = .systemBlue
                case 20...29:
                    label.backgroundColor = .red
                default:
                    label.backgroundColor = .lightGray
                }
                
                DispatchQueue.main.async {
                    label.layer.cornerRadius = label.layer.frame.height / 2
                }
            }
        }
    }
    
    private func setTitleLabel() {
        guard var str = textField.text else { return }
        str += "회 당첨결과"
        
        let numberStr = str.split(separator: " ").map { String($0) }[0]
        
        let attributedStr = NSMutableAttributedString(string: str)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: (str as NSString).range(of: numberStr))
        
        titleLabel.attributedText = attributedStr
    }
    
    
    
}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        1122
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(pickerView.numberOfRows(inComponent: 0) - row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NetworkManager.shared.getLotto("\(pickerView.numberOfRows(inComponent: 0) - row)") { data, numbers in
            self.configureLottoUI(numbers)
            self.textField.text = "\(data.drwNo)"
            self.setTitleLabel()
            self.dateLabel.text = data.drwNoDate
        }
    }
    
}
