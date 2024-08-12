//
//  BaseViewModel.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/12/24.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
