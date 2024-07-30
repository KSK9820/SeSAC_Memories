//
//  SimpleUISwitchViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleUISwitchViewController: UIViewController {
    
    let label = UILabel()
    let switchView = UISwitch()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(switchView)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.horizontalEdges.equalToSuperview()
        }
        switchView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        setswitchView()
    }
    
    func setswitchView() {
        Observable.of(false)
            .bind(to: switchView.rx.isOn)
            .disposed(by: disposeBag)
        
        switchView.rx.isOn
            .map { data in
                "\(data)"
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
