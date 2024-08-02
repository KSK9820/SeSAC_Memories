//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let descriptionLabel = UILabel()
    
    let phoneNumber = BehaviorSubject(value: "010")
    let validText = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        bind()
    }
    

    
    
    private func bind() {
        validText
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        phoneNumber
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        let validation = phoneTextField.rx.text.orEmpty
            .map { text -> ValidationState in
                let isNumeric = text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
                if !isNumeric {
                    return ValidationState.containCharacter
                }
                if text.count < 10 {
                    return ValidationState.short
                }
                return ValidationState.normal
            }
            
        
        validation
            .bind(with: self, onNext: { owner, value in
                switch value {
                case .containCharacter:
                    owner.validText.onNext("문자는 포함될 수 없습니다.")
                case .short:
                    owner.validText.onNext("10자 이상 입력해주세요.")
                case .normal:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        validation
            .map { state in
                switch state {
                case .normal:
                    return true
                case .containCharacter, .short:
                    return false
                }
            }
            .bind(to: nextButton.rx.isEnabled, descriptionLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        validation
            .bind(with: self) { owner, value in
                owner.descriptionLabel.textColor = .systemPink
                let color: UIColor?
                switch value {
                case .containCharacter, .short:
                    color = .gray
                case .normal:
                    color = .systemPink
                }
                owner.nextButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
    }


    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        view.addSubview(descriptionLabel)
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

enum ValidationState {
    case containCharacter
    case short
    case normal
}
