//
//  TransferTableViewCellDataDelegate.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import UIKit

protocol TransferTableViewCellDataDelegate: AnyObject {
    func textFieldValueDidChange(value: String?)
    func textViewValueDidChange(value: String?)
}
