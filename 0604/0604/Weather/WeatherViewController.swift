//
//  WeatherViewController.swift
//  0604
//
//  Created by 김수경 on 6/7/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

final class WeatherViewController: UIViewController {
    
    var location = "London"
    var weatherData: Weather?
    
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let weatherLabel = InsetLabel(labelPadding: InsetLabel.PaddingLabel(topInset: 12, bottomInset: 12, leadingInset: 12, trailingInset: 12))
    private let weatherImageView = UIImageView()
    private let endLabel = InsetLabel(labelPadding: InsetLabel.PaddingLabel(topInset: 12, bottomInset: 12, leadingInset: 12, trailingInset: 12))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getWeatherData()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy() {
        let views = [dateLabel, locationLabel, weatherLabel, weatherImageView, endLabel]
        
        views.forEach { components in
            view.addSubview(components)
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeArea).inset(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea).offset(20)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea).offset(20)
        }
        
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea).offset(20)
        }
        
        endLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
            make.leading.equalTo(safeArea).offset(20)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let views = [weatherLabel, endLabel]
        
        views.forEach { label in
            label.backgroundColor = .systemOrange.withAlphaComponent(0.6)
            label.layer.cornerRadius = 8
        }
    }
    
    private func getWeatherData() {
        let url = APIURL.weather(location).urlString
        guard let parameter = APIURL.weather(location).parameter else { return }
        
        AF.request(url, parameters: parameter).responseDecodable(of: WeatherResponseModel.self) { response in
            switch response.result {
            case .success(let data):
                self.weatherData = data.weather[0]
                self.setContents()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setContents() {
        if let weatherData {
            dateLabel.text = Date().formatted()
            locationLabel.text = location
            weatherLabel.text = "today weather is \(weatherData.main)"
            endLabel.text = "have a nice day!"
            
            let url = URL(string: APIURL.weatherImage(weatherData.icon).urlString)
            weatherImageView.kf.setImage(with: url)
        }
    }
}

