//
//  SignInViewController.swift
//  0604
//
//  Created by 김수경 on 6/5/24.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        
        label.textColor = .systemOrange
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.text = "NETFLIX"
        
        return label
    }()
    
    private let stackView: UIStackView = {
       let view = UIStackView()
        
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 12
        
        return view
    }()
    
    private lazy var textFieldArray: [UITextField] = [
        makeTextField("이메일 주소 또는 전화번호"),
        makeTextField("비밀번호"),
        makeTextField("닉네임"),
        makeTextField("위치"),
        makeTextField("추천 코드 입력")
    ]
    
    private let signInButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private let additionalButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("추가 정보 입력", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let toggleSwitch: UISwitch = {
        let view = UISwitch()
        
        view.onTintColor = .systemOrange
        view.thumbTintColor = .systemYellow
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
    }
    
    private func configureHierarchy() {
        view.addSubview(titleLabel)
        
        textFieldArray.forEach { textfield in
            stackView.addArrangedSubview(textfield)
        }
        
        view.addSubview(stackView)
        view.addSubview(signInButton)
        view.addSubview(additionalButton)
        view.addSubview(toggleSwitch)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(30)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        textFieldArray.forEach { textfield in
            textfield.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        additionalButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.leading.equalTo(safeArea).offset(30)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.trailing.equalTo(safeArea).offset(-30)
        }
        
    }
    
    private func makeTextField(_ placeHolder: String) -> UITextField {
        let view = UITextField()
        
        view.placeholder = placeHolder
        view.backgroundColor = .gray
        view.textAlignment = .center
        view.layer.cornerRadius = 8
        view.textColor = .white
        
        return view
    }
}
