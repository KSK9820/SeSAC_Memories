//
//  SearchViewModel.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    var searchResultData = [AppStoreResult]()
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonTap: ControlEvent<Void>
        let collectionViewItemTap: ControlEvent<IndexPath>
    }
    
    struct Output {
        let searchResult: PublishSubject<[AppStoreResult]>
        let collectionViewItemTap: ControlEvent<IndexPath>
        let tapResult: PublishSubject<AppStoreResult>
    }
    
    func transform(_ input: Input) -> Output {
        let searchResult = PublishSubject<[AppStoreResult]>()
        let selectResult = PublishSubject<AppStoreResult>()
        
        input.searchButtonTap
            .withLatestFrom(input.searchText) { _, value in
                return value
            }
            .distinctUntilChanged()
            .flatMap {
                NetworkManager.shared.getSearchData($0)
            }
            .subscribe(with: self) { owner, value in
                owner.searchResultData = value.results
                searchResult.onNext(owner.searchResultData)
            }
            .disposed(by: disposeBag)
        
        input.collectionViewItemTap
            .subscribe(with: self) { owner, value in
                selectResult.onNext(owner.searchResultData[value.row])
            }
            .disposed(by: disposeBag)
            
        
        return Output(searchResult: searchResult, collectionViewItemTap: input.collectionViewItemTap, tapResult: selectResult)
    }
    
}
