//
//  GoogleMapsManager.swift
//  Bway
//
//  Created by Thiago on 08/11/19.
//  Copyright © 2019 Bway. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

protocol GoogleMapsManagerDelegate {
    
    func didTapLocation(coordinate: CLLocationCoordinate2D)
}

class GoogleMapsManager: NSObject {
    
    // MARK:- Properties
    var mapView: GMSMapView?
    var locationMarker: GMSMarker? = GMSMarker()
    var locationManager = LocationManager()
    var location: CLLocationCoordinate2D?
    var geoCoder:GMSGeocoder?
    var delegate: GoogleMapsManagerDelegate?
    var locationInit: CLLocationCoordinate2D?
    var locationIsReady = false
    var productEnumReferenceSelected = ""
    var currentLocationMarker: GMSMarker? = GMSMarker()
    
    override init(){
        super.init()
    }
    
    func setMap(googleMapsView: GMSMapView) {
        self.mapView = googleMapsView
        self.mapView?.settings.compassButton = true
        mapView?.tintAdjustmentMode = .normal
        self.mapView?.isMyLocationEnabled = false
        self.mapView?.settings.myLocationButton = true
        mapView?.settings.scrollGestures = true
        mapView?.delegate = self
        mapView?.settings.zoomGestures = true
    }
    
    func setLocation(googleMapsView: GMSMapView) {
        self.setMap(googleMapsView: googleMapsView)
        self.locationManager.delegate = self
        self.locationManager.getLocation()
    }
}

//MARK:- Maps Delegates
extension GoogleMapsManager : GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.delegate?.didTapLocation(coordinate: coordinate)
    }
    
    func setMarkDefault(center:CLLocationCoordinate2D) {
        self.mapView?.isMyLocationEnabled = false
        if let _ = self.currentLocationMarker {
            self.currentLocationMarker?.map = nil
        }
        let marker = GMSMarker(position: center)
        self.currentLocationMarker = marker
        marker.map = self.mapView
    }
}

extension GoogleMapsManager : LocationManagerDelegate {
    
    func getCurrentLocation(currentLocation: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 14)
        
        print("Latitude = "+currentLocation.coordinate.latitude.description)
        print("Longitude = "+currentLocation.coordinate.longitude.description)
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        self.mapView?.camera = camera
        self.mapView?.animate(toLocation: currentLocation.coordinate)
        self.mapView?.animate(to: camera)
        self.locationInit = currentLocation.coordinate
        self.setMarkDefault(center: center)
    }
    func autorizationDenied(){
    }
}
