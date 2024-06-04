//
//  ViewController.swift
//  0604
//
//  Created by 김수경 on 6/4/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    lazy var netflixButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("go to netFlix", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(netflixButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("go to signIn", for: .normal)
        button.backgroundColor = .blue
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
    }
    
    private func configureHierarchy() {
        view.addSubview(netflixButton)
        view.addSubview(signInButton)
    }
    
    private func configureLayout() {
        netflixButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.width.equalTo(200)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(netflixButton.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc func netflixButtonTapped() {
        let vc = NetflixViewController()
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
}

