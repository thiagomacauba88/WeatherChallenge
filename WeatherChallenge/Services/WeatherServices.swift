//
//  WeatherServices.swift
//  WeatherChallenge
//
//  Created by Thiago on 03/07/20.
//  Copyright © 2020 WeatherChallenge. All rights reserved.
//

import UIKit

class WeatherServices {
    
    // MARK: - Urls
    func getWeatherUrl(latitude: String, longitude: String) -> String {
        var url = URLInfo.url(fromKey: "weather")
        url = url.replacingOccurrences(of: "{latitude}", with: latitude)
        url = url.replacingOccurrences(of: "{longitude}", with: longitude)
        return url
    }
        
    // MARK: - Services
    func weather(latitude: String, longitude: String,  success: @escaping ((_ sucessObject: WeatherResponse? ,_ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getWeatherUrl(latitude: latitude, longitude: longitude)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil, auth: true).response(succeed: { (_ topBank: WeatherResponse?, _ serviceResponse: ServiceResponse?) in
                    if let response = topBank, let content = serviceResponse {
                        success(response, content)
                    }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
}
