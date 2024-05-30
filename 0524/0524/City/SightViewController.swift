//
//  SightViewController.swift
//  0524
//
//  Created by 김수경 on 5/29/24.
//

import UIKit
import Kingfisher

final class SightViewController: UIViewController {
    
    var contents: Travel?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var sightTitle: UILabel!
    @IBOutlet var sightDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setUI()
        setContents()
    }
    
    @objc
    func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(popButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        sightTitle.textAlignment = .center
        sightTitle.font = .titleTextFont
        
        sightDescription.textAlignment = .center
        sightDescription.font = .contentsTextFont
        sightDescription.numberOfLines = 0 
    }
    
    private func setContents() {
        if let title = contents?.title {
            navigationItem.title = title
            sightTitle.text = title
        }
        
        if let image = contents?.travel_image {
            let url = URL(string: image)
            imageView.kf.setImage(with: url)
        }
        
        if let description = contents?.description {
            sightDescription.text = description
        }
    }
}

