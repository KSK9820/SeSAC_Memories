//
//  TravelInfoViewController.swift
//  0524
//
//  Created by 김수경 on 5/29/24.
//

import UIKit

class TravelInfoViewController: UIViewController {
    
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    var travelInfo: [City] = CityInfo().city
    lazy var searchInfo: [City] = travelInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        citySegmentedControl.setTitle("모두", forSegmentAt: 0)
        citySegmentedControl.setTitle("국내", forSegmentAt: 1)
        citySegmentedControl.setTitle("해외", forSegmentAt: 2)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TravelInfoTableViewCell", bundle: nil), forCellReuseIdentifier: TravelInfoTableViewCell.identifier)
        
        tableView.separatorStyle = .none
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            searchInfo = travelInfo
        } else if sender.selectedSegmentIndex == 1 {
            searchInfo = travelInfo.filter { $0.domestic_travel == true }
        } else if sender.selectedSegmentIndex == 2 {
            searchInfo = travelInfo.filter { $0.domestic_travel == false }
        }
        
        tableView.reloadData()
    }
    
}


extension TravelInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
        160
    }
    
}

extension TravelInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier, for: indexPath) as? TravelInfoTableViewCell else { return UITableViewCell() }
        
        cell.setContent(searchInfo[indexPath.row])
        
        return cell
    }
    
    
}
