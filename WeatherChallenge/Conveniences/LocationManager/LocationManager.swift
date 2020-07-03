//
//  LocationManager.swift
//  Bway
//
//  Created by Thiago on 08/11/19.
//  Copyright © 2019 Bway. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Delegate
@objc  protocol LocationManagerDelegate {
    func getCurrentLocation(currentLocation: CLLocation)
    func autorizationDenied()
    @objc optional func getGeocoder(placeMark: CLPlacemark)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Properties
    var location = CLLocationManager()
    var delegate: LocationManagerDelegate?
    
    // MARK: - Functions
    func getLocation() {
        self.location.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.location.delegate = self
            self.location.desiredAccuracy = kCLLocationAccuracyBest
            self.location.distanceFilter = 50
            self.location.startUpdatingLocation()
        }
    }
    
    func stopLocation () {
        self.location.stopUpdatingLocation()
        self.location.stopMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.delegate?.getCurrentLocation(currentLocation: location)
            self.getGeocoder(location: location)
        }
    }
    
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
            self.delegate?.autorizationDenied()
        }
    }
    
    func getGeocoder(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            if let errorGeo = error {
                print("Reverse geocoder failed with error" + errorGeo.localizedDescription)
                return
            }
            if let places = placemarks {
                if places.count > 0 {
                    let pm = places[0]
                    self.delegate?.getGeocoder?(placeMark: pm)
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            }
        })
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
        }
        alertController.addAction(openAction)
    }
}


