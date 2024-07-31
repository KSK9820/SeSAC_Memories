//
//  SimpleTableView2Controller.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleTableView2Controller: UIViewController, UITableViewDelegate {
    
    private let tableview = UITableView()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        let items = Observable.just((0..<20).map { "\($0)"})
        
        items
            .bind(to: tableview.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.accessoryType = .detailButton
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableview.rx
            .modelSelected(String.self)
            .subscribe(onNext: { [weak self] value in
                self?.showAlert(value)
            })
            .disposed(by: disposeBag)
        
        tableview.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { [weak self] indexPath in
                self?.showAlert("\(indexPath.section) \(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
    
    func showAlert(_ value: String) {
        let alert = UIAlertController(
            title: "RxExample",
            message: value,
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:    "Cell")
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

