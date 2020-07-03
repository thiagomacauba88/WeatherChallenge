//
//  WheaterResponse.swift
//  WeatherChallenge
//
//  Created by Thiago on 03/07/20.
//  Copyright © 2020 WeatherChallenge. All rights reserved.
//

import UIKit

class WeatherResponse: Codable {

    var data: [DataItemResponse]?
    var latitude: String?
    var longitude: String?
}

class DataItemResponse: Codable {

    var temp: Double?
    var city_name: String?
    var state_code: String?
}
