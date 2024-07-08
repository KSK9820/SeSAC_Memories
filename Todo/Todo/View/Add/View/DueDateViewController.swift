//
//  DueDateViewController.swift
//  Todo
//
//  Created by 김수경 on 7/4/24.
//

import UIKit
import SnapKit

final class DueDateViewController: UIViewController {
    
    var saveDueDate: ((Date) -> Void)?
    
    private let datePicker: UIDatePicker = {
        let view = UIDatePicker()
        
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        view.locale = Locale(identifier: "ko_KR")
        view.tintColor = .white
        
        view.setValue(UIColor.white, forKeyPath: "textColor")
        
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
        view.addSubview(datePicker)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(30)
            make.directionalHorizontalEdges.equalTo(safeArea).inset(20)
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
        saveDueDate?(datePicker.date)
        navigationController?.popViewController(animated: false)
    }
}
