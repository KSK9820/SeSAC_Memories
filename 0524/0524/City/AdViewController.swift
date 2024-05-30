//
//  AdViewController.swift
//  0524
//
//  Created by 김수경 on 5/29/24.
//

import UIKit

final class AdViewController: UIViewController {
    
    var contents: Travel?
    var color: UIColor?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setContents()
    }
    
    private func setUI() {
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        titleLabel.font = .titleTextFont
        titleLabel.textAlignment = .center
        
        adLabel.font = .titleTextFont
        adLabel.textAlignment = .center
        adLabel.numberOfLines = 0 
        
    }
    
    private func setContents() {
        titleLabel.text = "!!!!!!!!!광고!!!!!!!!!"
        
        if let description = contents?.title {
            adLabel.text = description
        }
    }
    
    @objc
    func dismissButtonTapped() {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}
