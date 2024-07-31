//
//  AddingNumberViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class AddingNumberViewController: UIViewController {
    
    private let number1 = UITextField()
    private let number2 = UITextField()
    private let number3 = UITextField()
    private let result = UILabel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
        
        number1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        result.snp.makeConstraints { make in
            make.top.equalTo(number3).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        
        number1.backgroundColor = .red
        number2.backgroundColor = .orange
        number3.backgroundColor = .cyan
    }
    
}
