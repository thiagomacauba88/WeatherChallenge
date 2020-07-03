//
//  ViewController.swift
//  WeatherChallenge
//
//  Created by Thiago on 03/07/20.
//  Copyright © 2020 WeatherChallenge. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift

class WeatherViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var mapView: GMSMapView!
    
    // MARK: - Properties
    var googleMapsManager = GoogleMapsManager()
    let disposeBag = DisposeBag()
    let viewModel = WeatherViewModel()
    let router = WeatherRouter()
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var lastSearchView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lastSearchViewTapGesture))
            self.lastSearchView.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGoogleMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initViews()
    }
    
    // MARK: - MISC
    private func initViews() {
        self.title = "My Location"
        self.setStatusBar()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let latitude: String = UserDefault().getLatitude()
        if latitude != "" {
            self.lastSearchView.isHidden = false
            self.cityLabel.text = UserDefault().getCity()
            self.tempLabel.text = UserDefault().getTemp()
        }
        
    }
    
    private func initGoogleMap() {
        self.googleMapsManager.setLocation(googleMapsView: self.mapView)
        self.googleMapsManager.delegate = self
    }
    
    @objc private dynamic func lastSearchViewTapGesture(_ gesture: UITapGestureRecognizer) {
        let weatherResponse = WeatherResponse()
        weatherResponse.data = []
        weatherResponse.latitude = UserDefault().getLatitude()
        weatherResponse.longitude = UserDefault().getLongitude()
        let dataItemResponse = DataItemResponse()
        dataItemResponse.city_name = UserDefault().getCity()
        dataItemResponse.temp = Double(UserDefault().getTemp().replacingOccurrences(of: "°C", with: ""))
        weatherResponse.data?.append(dataItemResponse)
        self.router.react(to: .itemTapped, from: self, info: weatherResponse)
    }
}

// MARK: - Services
extension WeatherViewController {
    
    func weather(latitude: String, longitude: String) {
        self.view.startLoading()
        self.viewModel.weather(latitude: latitude, longitude: longitude)
            .observeOn(MainScheduler.instance).subscribe(onNext: { (response) in
                self.viewModel.weatherResponse?.longitude = longitude
                self.viewModel.weatherResponse?.latitude = latitude
                self.router.react(to: .itemTapped, from: self, info: self.viewModel.weatherResponse)
            }, onError: { (error) in
                self.showAlertError(for: error)
            }, onCompleted: {
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
}

// MARK: - GoogleMapsManagerDelegate
extension WeatherViewController: GoogleMapsManagerDelegate {
    
    func didTapLocation(coordinate: CLLocationCoordinate2D) {
        self.weather(latitude: coordinate.latitude.description, longitude: coordinate.longitude.description)
    }
}

// MARK: - Instantiation
extension WeatherViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> WeatherViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! WeatherViewController
    }
}
