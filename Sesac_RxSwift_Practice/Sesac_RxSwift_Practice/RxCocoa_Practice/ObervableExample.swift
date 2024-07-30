//
//  ObervableExample.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ObservableExample: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        justTest()
        ofTest()
        fromTest()
        takeTest()
    }
    
    private func justTest() {
        Observable.just([1,2,3,4,5,6])
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just - completed")
            } onDisposed: {
                print("just - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func ofTest() {
        let a = [1,2,3,4,5]
        let b = [5,4,3,2,1]
        
        Observable.of(a,b)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of - completed")
            } onDisposed: {
                print("of - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func fromTest() {
        Observable.from([1,2,3,4,5])
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from - completed")
            } onDisposed: {
                print("from - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func takeTest() {
        Observable.repeatElement("take")
            .take(5)
            .subscribe { value in
                print("take - \(value)")
            } onError: { error in
                print("take - \(error)")
            } onCompleted: {
                print("take - completed")
            } onDisposed: {
                print("take - disposed")
            }
            .disposed(by: disposeBag)
    }
    
}
