//
//  KaKaoViewController.swift
//  0517
//
//  Created by 김수경 on 5/21/24.
//

import UIKit

class KaKaoViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        backgroundImageView.layer.opacity = 0.5
        profileImageView.layer.cornerRadius = 30
    }
}
