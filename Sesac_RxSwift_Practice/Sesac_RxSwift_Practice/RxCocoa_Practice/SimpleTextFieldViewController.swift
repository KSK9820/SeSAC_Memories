//
//  SimpleTextFieldViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTextFieldViewController: UIViewController {
    
    let signEmail = UITextField()
    let signName = UITextField()
    let label = UILabel()
    let loginButton = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(signEmail)
        view.addSubview(signName)
        view.addSubview(label)
        view.addSubview(loginButton)
        
        signEmail.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalToSuperview().inset(100)
        }
        signName.snp.makeConstraints { make in
            make.top.equalTo(signEmail.snp.bottom).offset(100)
            make.horizontalEdges.equalToSuperview().inset(100)
        }        
        label.snp.makeConstraints { make in
            make.top.equalTo(signName.snp.bottom).offset(100)
            make.horizontalEdges.equalToSuperview().inset(100)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(100)
            make.horizontalEdges.equalToSuperview().inset(100)
        }
        
        signName.backgroundColor = .green
        signEmail.backgroundColor = .blue
        label.backgroundColor = .systemPink
        loginButton.backgroundColor = .red
        
        setSign()
    }
    
    func setSign() {
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) {
            value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다."
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }  // Observable<Bool>
            .bind(to: signEmail.rx.isHidden, loginButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        loginButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

}
