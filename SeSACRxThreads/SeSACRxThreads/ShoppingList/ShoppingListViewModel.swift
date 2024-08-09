//
//  ShoppingListViewModel.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/8/24.
//

import Foundation
import RxCocoa
import RxSwift

final class ShoppingListViewModel {
    
    let disposeBag = DisposeBag()
    
    private var data = [ShoppingList]()
    private let selectData = ["과자", "디저트", "집", "부동산", "놀이공원", "유튜브", "반포자이", "한강", "잠실롯데타워"]
    
    struct Input {
        let addButtonTap: ControlEvent<Void>
        let addText: ControlProperty<String>
        let searchText: Observable<String>
        let selectItem: ControlEvent<String>
        let checkButtonTap: PublishSubject<Int>
        let starButtonTap: PublishSubject<Int>
    }
    
    struct Output {
        let addButtonTap: ControlEvent<Void>
        let shoppingList: BehaviorSubject<[ShoppingList]>
        let searchText: Observable<String>
        let selectList: BehaviorSubject<[String]>
    }

    
    func transform(input: Input) -> Output {
        let shoppingList = BehaviorSubject(value: data)
        let selectList = BehaviorSubject(value: selectData)
        
        input.addButtonTap
            .withLatestFrom(input.addText, resultSelector: { _, value in
                return value
            })
            .subscribe(with: self) { owner, value in
                if !value.isEmpty {
                    let shoppingData = ShoppingList(title: value)
                    owner.data.append(shoppingData)
                    shoppingList.onNext(owner.data)
                }
            }
            .disposed(by: disposeBag)
        
        input.searchText
            .subscribe(with: self) { owner, value in
                if value.isEmpty {
                    shoppingList.onNext(owner.data)
                } else {
                    let searchData = owner.data.filter { $0.title.contains(value) }
                    shoppingList.onNext(searchData)
                }
            }
            .disposed(by: disposeBag)
        
        input.selectItem
            .withUnretained(self)
            .map { "\($0.1) 구매하기" }
            .bind(with: self, onNext: { owner, value in
                let shoppingItem = ShoppingList(title: value)
                owner.data.append(shoppingItem)
                shoppingList.onNext(owner.data)
            })
            .disposed(by: disposeBag)
            
        input.checkButtonTap
            .subscribe(with: self) { owner, value in
                owner.data[value].done.toggle()
                shoppingList.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        input.starButtonTap
            .subscribe(with: self) { owner, value in
                owner.data[value].star.toggle()
                owner.data = owner.data.sorted { $0.date < $1.date }.sorted { $0.star && !$1.star }
                shoppingList.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        
        return Output(addButtonTap: input.addButtonTap, shoppingList: shoppingList, searchText: input.searchText, selectList: selectList)
    }
    
}
