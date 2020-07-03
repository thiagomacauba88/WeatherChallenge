//
//  UserDefaults.swift
//  Top Bank
//
//  Created by Thiago on 06/03/20.
//  Copyright © 2020 Valecard. All rights reserved.
//

import UIKit

import UIKit

class UserDefault {
    
    func removeUserLogin(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "login")
    }
    
    func saveLatitude(_ latitude: String){
        let defaults = UserDefaults.standard
        defaults.set(latitude, forKey: "latitude")
    }
    
    func getLatitude() -> String {
        let defaults = UserDefaults.standard
        if let latitude = defaults.string(forKey: "latitude") {
            return latitude
        } else {
            return ""
        }
    }
    
    func saveLongitude(_ longitude: String){
        let defaults = UserDefaults.standard
        defaults.set(longitude, forKey: "longitude")
    }
    
    func getLongitude() -> String {
        let defaults = UserDefaults.standard
        if let longitude = defaults.string(forKey: "longitude") {
            return longitude
        } else {
            return ""
        }
    }
    
    func saveCity(_ city: String){
        let defaults = UserDefaults.standard
        defaults.set(city, forKey: "city")
    }
    
    func getCity() -> String {
        let defaults = UserDefaults.standard
        if let city = defaults.string(forKey: "city") {
            return city
        } else {
            return ""
        }
    }
    
    func saveTemp(_ temp: String){
        let defaults = UserDefaults.standard
        defaults.set(temp, forKey: "temp")
    }
    
    func getTemp() -> String {
        let defaults = UserDefaults.standard
        if let temp = defaults.string(forKey: "temp") {
            return temp
        } else {
            return ""
        }
    }
}
