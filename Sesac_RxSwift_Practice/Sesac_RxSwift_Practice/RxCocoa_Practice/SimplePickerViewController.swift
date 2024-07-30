//
//  SimplePickerViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimplePickerViewController: UIViewController {
    
    let label = UILabel()
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(pickerView)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.horizontalEdges.equalToSuperview()
        }
        pickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        setPickerView()
    }
    
    func setPickerView() {
        let items = Observable.just(["영화", "애니메이션", "드라마", "기타"])
        items.bind(to: pickerView.rx.itemTitles) { (row, element) in
            return element
        }
        .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
