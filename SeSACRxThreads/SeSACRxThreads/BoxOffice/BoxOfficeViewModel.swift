//
//  BoxOfficeViewModel.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel {
    
    let disposeBag = DisposeBag()
    
    private var recentList = [String]()
    
    
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonTap: ControlEvent<Void>
        let selectedText: PublishSubject<String>
    }
    
    struct Output {
        let movieList: Observable<[DailyBoxOfficeList]>
        let recentList: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        let boxOfficeList = PublishSubject<[DailyBoxOfficeList]>()
        let recentList = PublishSubject<[String]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map {
                guard let intText = Int($0) else { return "20240808" }
                return "\(intText)"
            }
            .flatMap { value in
                MovieNetworkManager.shared.callRequest(date: value)
            }
            .subscribe(with: self) { owner, value in
                boxOfficeList.onNext(value.boxOfficeResult.dailyBoxOfficeList)
            }
            .disposed(by: disposeBag)
            
        input.selectedText
            .subscribe(with: self) { owner, value in
                owner.recentList.append(value)
                recentList.onNext(owner.recentList)
            }
            .disposed(by: disposeBag)
        
        
        return Output(movieList: boxOfficeList, recentList: recentList)
    }
    
    
}
