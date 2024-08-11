//
//  Then.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import Foundation

protocol Then { }

extension Then where Self: AnyObject {
    func then(_ handler: (Self) -> Void) -> Self {
        handler(self)
        return self
    }
}

extension NSObject: Then { }

