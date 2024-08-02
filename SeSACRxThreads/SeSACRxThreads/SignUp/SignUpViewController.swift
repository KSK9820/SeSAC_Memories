//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    let validationLabel = {
        let view = UILabel()
       
        view.textColor = .red
        
        return view
    }()
    
    let validText = PublishSubject<String>()
    let validDuplicate = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        bind()
    }
    
    private func bind() {
        validText
            .bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        validDuplicate
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        let validation = emailTextField.rx.text.orEmpty
            .map { $0.contains("@") }
        
        validation
            .bind(with: self) { owner, value in
                if !value {
                    owner.validText.onNext("이메일에 @가 포함되지 않았습니다.")
                    owner.validDuplicate.onNext(false)
                }
                owner.nextButton.backgroundColor = .lightGray
            }
            .disposed(by: disposeBag)
        
        validation
            .bind(to: validationButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        validationButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.validDuplicate.onNext(true)
                
                owner.nextButton.backgroundColor = .systemPink
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(PasswordViewController(), animated: true)
            }
            .disposed(by: disposeBag)
            
    }


    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        view.addSubview(validationLabel)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(validationButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
