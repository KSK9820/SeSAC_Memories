//
//  ButtonViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ButtonViewController: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.horizontalEdges.equalToSuperview()
        }
        
        button.backgroundColor = .green
        label.backgroundColor = .brown
        
        button1()
    }
    
    
    // 가장 기본
    private func button1() {
        // UI관련이기 때문에 Infinite Observable Sequence
        button          // UIButton
            .rx         // Reactive<Self>: Reactive<UIButton>
            .tap        // ControlEvent<Void>: ControlEvent<Void>
            .subscribe { _ in
                self.label.text = "버튼을 클릭했어요"
                print("next")
            } onError: { error in
                print("error")
            } onCompleted: {
                print("complete")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // Infinite Observable Sequence
    // -> complte와 error가 굳이 발생하지 않는다: 생략
    private func button2() {
        button.rx.tap
            .subscribe { _ in
                self.label.text = "버튼을 클릭했어요"
                print("next")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 누수 발생을 swift적으로 해결
    // 누수가 발생하는 이유(추측) subscribe 내부의 observer가 초기화시에 탈출클로저를 매개변수로 받기 때문
    private func button3() {
        button.rx.tap
            .subscribe { [weak self] _ in
                self?.label.text = "버튼을 클릭했어요"
                print("next")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 누수 발생을 rxswift의 연산자를 통해 해결
    private func button4() {
        button.rx.tap
            .withUnretained(self)
            .subscribe { _ in
                self.label.text = "버튼을 클릭했어요"
                print("next")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 4번과 동일하지만 다른 표현
    private func button5() {
        button.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.label.text =  "버튼을 클릭했어요"
                print("next")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    
    // UI업데이트 - GCD
    private func button6() {
        button.rx.tap
            .observe(on: MainScheduler.instance) // 이후부터는 main 스레드에서 동작
            .subscribe(with: self) { owner, _ in
                owner.label.text = "버튼을 클릭했어요"
                print("next")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // UI업데이트 - Rx Operator
    private func button7() {
        button.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, _ in
                owner.label.text =  "버튼을 클릭했어요"
                print("next")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // UI에 적절한 형태 bind
    
    private func button8() {
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.label.text =  "버튼을 클릭했어요"
                print("next")
            }
            .disposed(by: disposeBag)
    }
    
    private func button9() {
        button.rx.tap
            .map { "버튼을 클릭했어요" } // ControlEvent<Void>가 Observable<String>이 됨: 시간에 따라 데이터의 시퀸스가 흐름
                                    // event가 observable이 됨
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
}
