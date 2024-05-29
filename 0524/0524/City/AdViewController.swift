//
//  AdViewController.swift
//  0524
//
//  Created by 김수경 on 5/29/24.
//

import UIKit

final class AdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func dismissButtonTapped() {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}
