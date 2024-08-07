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
    
    struct Input {
        let addButtonTap: ControlEvent<Void>
        let addText: ControlProperty<String>
        let searchText: Observable<String>
        
    }
    
    struct Output {
        let addButtonTap: ControlEvent<Void>
        let shoppingList: BehaviorSubject<[ShoppingList]>
        let searchTitleText: Observable<String>
    }

    
    func transform(input: Input) -> Output {
        let shoppingList = BehaviorSubject(value: data)
        
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
        
        return Output(addButtonTap: input.addButtonTap, shoppingList: shoppingList, searchTitleText: input.searchText)
    }
    
}
