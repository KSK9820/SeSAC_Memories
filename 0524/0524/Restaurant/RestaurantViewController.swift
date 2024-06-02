//
//  RestaurantViewController.swift
//  0524
//
//  Created by 김수경 on 5/28/24.
//

import UIKit



final class RestaurantViewController: UIViewController {
    
    @IBOutlet var searchView: UIView!
    
    @IBOutlet var searchOptionSegmentedControl: UISegmentedControl!
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var restaurantTableView: UITableView!
    
    private var restaurantList = RestaurantList.restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        configureTableView()
    }
    
    private func setUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지도", style: .plain, target: self, action: #selector(mapButtonTapped))
        
        searchView.backgroundColor = .lightGray
        searchView.layer.cornerRadius = 10
        
        searchTextField.backgroundColor = .lightGray
        searchTextField.layer.cornerRadius = 10
        searchTextField.placeholder = "음식점 이름을 검색해보세용~"
        searchTextField.borderStyle = .none
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.backgroundColor = .lightGray
        searchButton.tintColor = .white
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
    }
    
    private func configureTableView() {
        restaurantTableView.rowHeight = UITableView.automaticDimension
    
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: RestaurantTableViewCell.identifier)
    }
    
    @objc func searchButtonTapped() {
        var result = [Restaurant]()
        if let search = searchTextField.text,
            search != "" {
            if searchOptionSegmentedControl.selectedSegmentIndex == 0 {
                for restaurant in RestaurantList.restaurantArray {
                    if restaurant.name.contains(search) {
                        result.append(restaurant)
                        continue
                    }
                }
            } else {
                for restaurant in RestaurantList.restaurantArray {
                    if restaurant.category.contains(search) {
                        result.append(restaurant)
                        continue
                    }
                }
            }
            restaurantList = result
        } else if searchTextField.text == "" {
            restaurantList = RestaurantList.restaurantArray
        }
        
        restaurantTableView.reloadData()
    }
    
    @objc func mapButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: MapViewController.reuseIdentifier) as? MapViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContext(restaurantList[indexPath.row])
        
        return cell
    }
   

}

