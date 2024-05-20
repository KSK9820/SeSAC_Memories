//
//  SignInViewController.swift
//  0517
//
//  Created by 김수경 on 5/20/24.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    @IBAction func tappedSignInButton(_ sender: UIButton) {

        resultLabel.text = ""
        
        if emailTextField.text == "" { return }
        
        guard let password =  passwordTextField.text else { return }
        if password.count < 6 { return }
        
        let pattern: String = "^[0-9]*$"
            
        
        guard let code = codeTextField.text else { return }
            
        if (code.range(of: pattern, options: .regularExpression) != nil) {
            resultLabel.text = "로그인 성공"
        }
        
    }
    
    
    private func setUI() {
        emailTextField.placeholder = "이메일 주소 또는 전화번호"
        
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.isSecureTextEntry = true
        
        nickNameTextField.placeholder = "닉네임"
        
        codeTextField.placeholder = "추천인 코드"
        codeTextField.keyboardType = .numberPad
        
        resultLabel.text = ""
        resultLabel.textColor = .red
        resultLabel.textAlignment = .center
        
        signInButton.setTitle("회원가입", for: .normal)
        signInButton.setTitleColor(.red, for: .normal)
    }


}

