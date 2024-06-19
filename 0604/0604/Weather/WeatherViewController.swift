//
//  WeatherViewController.swift
//  0604
//
//  Created by 김수경 on 6/7/24.
//

import UIKit
import CoreLocation
import Alamofire
import SnapKit
import Kingfisher

final class WeatherViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var weatherData: Weather?
    
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let weatherLabel = InsetLabel(labelPadding: InsetLabel.PaddingLabel(topInset: 12, bottomInset: 12, leadingInset: 12, trailingInset: 12))
    private let weatherImageView = UIImageView()
    private let endLabel = InsetLabel(labelPadding: InsetLabel.PaddingLabel(topInset: 12, bottomInset: 12, leadingInset: 12, trailingInset: 12))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthroization()
        
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
    
    private func getWeatherData(_ coordinate: CLLocationCoordinate2D) {
        let url = APIURL.currentWeather.urlString
        let parameter: Parameters = ["lat": coordinate.latitude, "lon": coordinate.longitude, "appid": APIKey.weather.apikey]
        
        AF.request(url, parameters: parameter, encoding: URLEncoding.queryString).responseDecodable(of: WeatherResponseModel.self) { response in
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

            weatherLabel.text = "today weather is \(weatherData.main)"
            endLabel.text = "have a nice day!"
            
            let url = URL(string: APIURL.weatherImage(weatherData.icon).urlString)
            weatherImageView.kf.setImage(with: url)
        }
    }
}


extension WeatherViewController {
    
    private func checkDeviceLocationAuthroization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthroization()
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "위치 서비스 불가", message: "위치 서비스가 꺼져있어, 위치 권한을 요청할 수 없습니다.")
                }
            }
        }
    }
    
    private func checkCurrentLocationAuthroization() {
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showAlert(title: "위치 권한 허용 불가", message: "위치 권한이 없습니다. 위치 권한을 허용해주세요.")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            showAlert(title: "위취 권한 허용 불가", message: "위치 권한이 없습니다.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okay = UIAlertAction(
            title: "확인",
            style: .default)
        
        alert.addAction(okay)
        
        present(alert, animated: true)
    }
    
    func getLocationName(_ location: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemark?.first {
                var address = ""
                if let locality = placemark.locality {
                    address += locality + " "
                }
                if let thoroughfare = placemark.thoroughfare {
                    address += thoroughfare + " "
                }
                if let subThoroughfare = placemark.subThoroughfare {
                    address += subThoroughfare + " "
                }
                
                DispatchQueue.main.async {
                    self.locationLabel.text = address
                }
            }
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            
            getWeatherData(coordinate)
            getLocationName(coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        showAlert(title: "위치 정보 검색 오류", message: "사용자의 위치 정보를 가져오지 못 했습니다.")
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthroization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkDeviceLocationAuthroization()
    }
    
}
