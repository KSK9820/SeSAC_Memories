//
//  TagViewController.swift
//  Todo
//
//  Created by 김수경 on 7/4/24.
//

import UIKit
import SnapKit

final class TagViewController: UIViewController {
    
    var saveTag: ((String?) -> Void)?
    
    private let tagTextField: UITextField = {
        let view = UITextField()
        
        view.textColor = .white
        view.borderStyle = .line
        view.tintColor = .white
        view.placeholder = "태그를 입력해주세요."
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16.0)
        ]
        
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: attributes)
        
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
        view.addSubview(tagTextField)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(30)
            make.horizontalEdges.equalTo(safeArea).inset(20)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc
    private func backButtonTapped() {
        saveTag?(tagTextField.text)
        navigationController?.popViewController(animated: false)
    }
}
