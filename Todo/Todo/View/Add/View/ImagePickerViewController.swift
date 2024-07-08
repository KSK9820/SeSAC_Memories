//
//  ImagePickerViewController.swift
//  Todo
//
//  Created by 김수경 on 7/8/24.
//

import UIKit
import PhotosUI

final class ImagePickerViewController: UIViewController {
    
    private let pickedImageView = {
        let view = UIImageView()
    
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let pickButton = {
        let view = UIButton()
       
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.setTitle("갤러리에서 사진 고르기", for: .normal)
        
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(pickButton)
        view.addSubview(pickedImageView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        pickButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(20)
            make.centerX.equalTo(safeArea)
        }
        pickedImageView.snp.makeConstraints { make in
            make.top.equalTo(pickButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea).inset(30)
            make.bottom.equalTo(safeArea).offset(-20)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        configurePHPicker()
        configureNavigation()
    }
    
    private func configurePHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc
    private func backButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("imageReceived"), object: nil, userInfo: ["image": pickedImageView.image?.pngData()])
        navigationController?.popViewController(animated: false)
    }
}


extension ImagePickerViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider {
            itemProvider.canLoadObject(ofClass: UIImage.self)
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.pickedImageView.image = image as? UIImage
                    self.pickedImageView.backgroundColor = .clear
                }
            }
        }
    }
    
    
}
