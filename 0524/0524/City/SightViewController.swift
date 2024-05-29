//
//  SightViewController.swift
//  0524
//
//  Created by 김수경 on 5/29/24.
//

import UIKit

final class SightViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "관광지 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(popButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
