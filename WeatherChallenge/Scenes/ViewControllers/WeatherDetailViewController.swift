//
//  WeatherDetailViewController.swift
//  WeatherChallenge
//
//  Created by Thiago on 03/07/20.
//  Copyright © 2020 WeatherChallenge. All rights reserved.
//

import UIKit
import GoogleMaps

class WeatherDetailViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    // MARK: - Properties
    var googleMapsManager = GoogleMapsManager()
    var weatherResponse: WeatherResponse?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMap()
        self.initViews()
    }
    
    // MARK: - MISC
    private func initMap() {
        
        let latitude = Double(self.weatherResponse?.latitude ?? "")
        let longitude = Double(self.weatherResponse?.longitude ?? "")
        
        let location = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
        let cameraPosition = GMSCameraPosition.camera(withLatitude: location.latitude,
                                              longitude: location.longitude,
                                                      zoom: 14)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.map = mapView
        mapView.selectedMarker = marker
        mapView.camera = cameraPosition
    }
    
    private func initViews() {
        self.title = "Info Location"
        self.cityLabel.text = self.weatherResponse?.data?.first?.city_name ?? ""
        if let state = self.weatherResponse?.data?.first?.state_code {
            self.cityLabel.text = (self.weatherResponse?.data?.first?.city_name ?? "") + " - " + state
        }
        self.tempLabel.text = (self.weatherResponse?.data?.first?.temp?.description ?? "") + "°C"
        self.saveLastSearch()
    }
    
    private func saveLastSearch() {
        UserDefault().saveLatitude(self.weatherResponse?.latitude ?? "")
        UserDefault().saveLongitude(self.weatherResponse?.longitude ?? "")
        UserDefault().saveCity(self.cityLabel.text ?? "")
        UserDefault().saveTemp(tempLabel.text ?? "")
    }
}

// MARK: - Instantiation
extension WeatherDetailViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> WeatherDetailViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! WeatherDetailViewController
    }
}
