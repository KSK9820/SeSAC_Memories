//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class NicknameViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let tap: ControlEvent<Void>
        let text: ControlProperty<String?>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let validText: BehaviorRelay<String>
        let validation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let validation = input.text
            .orEmpty
            .map { $0.count >= 2 }
        
        let text = BehaviorRelay(value: "닉네임은 2자 이상 입력")
        validation.bind(with: self) { owner, value in
            value ? text.accept("다음") : text.accept("닉네임은 2자 이상 입력")
        }
        .disposed(by: disposeBag)
        
        return Output(tap: input.tap, validText: text, validation: validation)
    }
    
}
