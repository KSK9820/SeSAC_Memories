//
//  Observable.swift
//  0523
//
//  Created by 김수경 on 7/18/24.
//

import Foundation

final class Observable<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func loadBind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
}
