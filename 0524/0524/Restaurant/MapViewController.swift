//
//  MapViewController.swift
//  0524
//
//  Created by 김수경 on 6/1/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController, ReuseIdentifiable {
    
    var contents = RestaurantList.restaurantArray
    var annotationsForRemove = [MKPointAnnotation]()
    var filteredContents: [Restaurant] = [] {
        didSet {
            setAnnotation(locations: filteredContents)
        }
        
    }

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setMap()
        setAnnotation(locations: contents)
    }
    
    private func setUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonTapped))
    }
    
    private func setMap() {
        if let latitude = contents.first?.latitude,
           let longitude = contents.first?.longitude {
               let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
               let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
               mapView.setRegion(region, animated: true)
           }
    }
   
    private func setAnnotation(locations: [Restaurant]) {
        var annotations = [MKPointAnnotation]()
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
        annotationsForRemove = annotations
    }
    
    private func setNewRestaurant(_ category: String) {
        mapView.removeAnnotations(annotationsForRemove)
        filteredContents = []
        for content in contents {
            if content.category == category {
                filteredContents.append(content)
            }
        }
    }
    
    
    @objc func filterButtonTapped() {
        
        let alert = UIAlertController(title: "필터", message: "카테고리를 선택해주세요", preferredStyle: .actionSheet)
        let all = UIAlertAction(title: "전체보기", style: .default) { [self] UIAlertAction in
            filteredContents = contents
        }
        let korean = UIAlertAction(title: "한식", style: .default) { [self] UIAlertAction in
           setNewRestaurant("한식")
        }
        let western = UIAlertAction(title: "양식", style: .default) { [self] UIAlertAction in
            setNewRestaurant("양식")
        }
        let japanese = UIAlertAction(title: "일식", style: .default) { [self] UIAlertAction in
            setNewRestaurant("일식")
        }
        let chinese = UIAlertAction(title: "중식", style: .default) { [self] UIAlertAction in
            setNewRestaurant("중식")
        }
        let flourbased = UIAlertAction(title: "분식", style: .default) { [self] UIAlertAction in
            setNewRestaurant("분식")
        }

        
        alert.addAction(all)
        alert.addAction(korean)
        alert.addAction(western)
        alert.addAction(japanese)
        alert.addAction(chinese)
        alert.addAction(flourbased)
        
        present(alert, animated: true)
    }
}
