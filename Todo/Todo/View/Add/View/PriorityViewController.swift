//
//  PriorityViewController.swift
//  Todo
//
//  Created by 김수경 on 7/4/24.
//

import UIKit
import SnapKit

enum TodoPriority: String, CaseIterable {
    case musthave = "중요 O  급함 O"
    case shouldhave = "중요 O  급함 X"
    case couldhave = "중요 X  급함 O"
    case wonthave = "중요 X  급함 X"
}

final class PriorityViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: TodoPriority.allCases.map { $0.rawValue })
        
        view.backgroundColor = .lightGray
        view.selectedSegmentIndex = 0
        
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
        view.addSubview(segmentedControl)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(30)
            make.horizontalEdges.equalTo(safeArea).inset(20)
            make.height.equalTo(100)
        }
    }
    
    // 순서대로 나오지 않는 문제가 있음
    private func configureUI() {
        view.backgroundColor = .black
        
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
       
        for index in 0..<segmentedControl.numberOfSegments {
            let label = UILabel()
            
            label.text = segmentedControl.titleForSegment(at: index)
            
            label.textAlignment = .center
            label.numberOfLines = 2
            label.adjustsFontSizeToFitWidth = true
            
            segmentedControl.setTitle(nil, forSegmentAt: index)
            
            let segmentView = segmentedControl.subviews[(index + (TodoPriority.allCases.count - 1)) % TodoPriority.allCases.count]
            segmentView.addSubview(label)
           
            label.frame = segmentView.bounds
            
            label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc
    private func backButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("priorityReceived"), object: nil, userInfo: ["priority": segmentedControl.selectedSegmentIndex])
        navigationController?.popViewController(animated: false)
    }
}
                                      

                                      
                                      

