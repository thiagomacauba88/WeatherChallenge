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

    @IBOutlet var mapView: GMSMapView!
    var googleMapsManager = GoogleMapsManager()
    let disposeBag = DisposeBag()
    let viewModel = WeatherViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGoogleMap()
    }

    private func initGoogleMap() {
        self.googleMapsManager.setLocation(googleMapsView: self.mapView)
        weather(latitude: 37.347855909974385, longitude: -122.02907290309668)
    }

}

// MARK: - Services
extension WeatherViewController {
    
    func weather(latitude: Double, longitude: Double) {
        //self.view.startLoading()
        self.viewModel.weather(latitude: latitude, longitude: longitude)
            .observeOn(MainScheduler.instance).subscribe(onNext: { (response) in
                print("ok")
            }, onError: { (error) in
                //self.showAlertTop(error: error, for: "", isError: true)
                print("ruim")
            }, onCompleted: {
            }, onDisposed: {
                //self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
}
