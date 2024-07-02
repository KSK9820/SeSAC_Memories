//
//  TransferTableViewCellDataDelegate.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import UIKit

@objc
protocol TransferTableViewCellDataDelegate: AnyObject {
    @objc optional func textFieldValueDidChange(value: String?)
}
