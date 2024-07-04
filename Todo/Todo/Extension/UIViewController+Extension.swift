//
//  UIViewController+Extension.swift
//  Todo
//
//  Created by 김수경 on 7/4/24.
//

import UIKit

extension UIViewController {
    
    func makeAlert(title: String, message: String, option: String?, completion: (() -> Void)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        
        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel)
        
        if let option {
            let ok = UIAlertAction(
                title: option,
                style: .default) { _ in
                    completion?()
                }
            alert.addAction(ok)
        }
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}
