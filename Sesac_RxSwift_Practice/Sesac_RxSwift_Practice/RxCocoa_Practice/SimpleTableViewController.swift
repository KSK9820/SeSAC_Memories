//
//  SimpleTableViewController.swift
//  Sesac_RxSwift_Practice
//
//  Created by 김수경 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewController: UIViewController {
    
    let label = UILabel()
    let tableView = UITableView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(tableView)
        
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setTableView()
    }
    
    func setTableView() {
        Observable
            .just(["영화", "애니메이션", "드라마", "기타"])
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
