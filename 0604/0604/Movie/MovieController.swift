//
//  MovieController.swift
//  0604
//
//  Created by 김수경 on 6/6/24.
//

import UIKit

import Alamofire
import SnapKit

final class MovieController: UIViewController {
    
    var movie: MovieResponseModel?
    
    private let textField: UITextField = {
        let view = UITextField()
            
        view.keyboardType = .numberPad
        view.textColor = .white
       
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("검색", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(getMovieData), for: .touchUpInside)
        
        return view
    }()
    
    private let boundaryView: UIView =  {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    
    private let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setYesterday()
        searchButton.sendActions(for: .touchUpInside)
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    
    private func configureHierarchy() {
        view.addSubview(searchButton)
        view.addSubview(boundaryView)
        view.addSubview(textField)
        view.addSubview(tableview)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(20)
            make.trailing.equalTo(safeArea).inset(20)
            make.width.equalTo(60)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-20)
            make.height.equalTo(2)
            make.bottom.equalTo(searchButton.snp.bottom)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.top)
            make.leading.equalTo(safeArea).offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-20)
            make.bottom.equalTo(boundaryView.snp.top).offset(-5)
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(boundaryView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea).inset(20)
            make.bottom.equalTo(safeArea)
            
        }
    }
    
    private func configureTableView() {
        tableview.dataSource = self
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableview.backgroundColor = .black
    }
    
    
    @objc func getMovieData() {
        guard let date = textField.text else { return }
        let url = APIURL.movie(date).urlString
        guard let parameter = APIURL.movie(date).parameter else { return }

        AF.request(url, parameters: parameter).responseDecodable(of: MovieResponseModel.self) { response in
            switch response.result {
            case .success(let data):
                self.movie = data
                DispatchQueue.main.async { [self] in
                    self.tableview.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setYesterday() {
        let now = Date()
        
        var calendar = Calendar.current
        
        if let koreaTimeZone = TimeZone(identifier: "Asia/Seoul") {
            calendar.timeZone = koreaTimeZone
        }
        
        var dayComponent = DateComponents()
        dayComponent.day = -1
        
        if let yesterday = calendar.date(byAdding: dayComponent, to: now) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            
            let yesterdayString = dateFormatter.string(from: yesterday)
            textField.text = yesterdayString
        }
    }
    
}


extension MovieController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movie {
            return movie.boxOfficeResult.dailyBoxOfficeList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        if let movie {
            cell.setContents(movie.boxOfficeResult.dailyBoxOfficeList[indexPath.row])
        }
        
        return cell
    }
    
}
