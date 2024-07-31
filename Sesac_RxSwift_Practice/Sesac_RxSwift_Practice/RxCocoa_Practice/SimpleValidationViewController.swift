//
//  SimpleValidationViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleValidationViewController: UIViewController {
    
    private let username = {
        let view = UITextField()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let password = {
        let view = UITextField()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let usernameTitleLabel = UILabel()
    private let passwordTitleLabel = UILabel()
    private let usernameValidLabel = UILabel()
    private let passwordValidLabel = UILabel()
    
    private let button = UIButton()
    
    var stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    let disposeBag = DisposeBag()
    let minimalUsernameLength = 5
    let minimalPasswordLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        let usernameValid = username.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        let passwordValid = password.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: password.rx.isEnabled )
            .disposed(by: disposeBag)
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        everythingValid
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
       
    }
    
    func showAlert() {
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
    
    func configureUI() {
        view.backgroundColor = .white
       
        view.addSubview(stackView)
        [usernameTitleLabel, username, usernameValidLabel, passwordTitleLabel, password, passwordValidLabel, button].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }
        
        usernameTitleLabel.text = "Username"
        passwordTitleLabel.text = "Password"
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        button.setTitle("Do something", for: .normal)
        button.backgroundColor = .blue
    }
    
}
