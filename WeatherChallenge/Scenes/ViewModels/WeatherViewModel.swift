//
//  WeatherViewModel.swift
//  WeatherChallenge
//
//  Created by Thiago on 03/07/20.
//  Copyright © 2020 WeatherChallenge. All rights reserved.
//

import UIKit
import RxSwift

class WeatherViewModel {

    // MARK: - Properties
    let service = WeatherServices()
    var weatherResponse: WeatherResponse?
    
    func weather(latitude: String, longitude: String) -> Observable<WeatherResponse?> {
        return Observable.create { observable in
            self.service.weather(latitude: latitude, longitude: longitude,
                success: { (findUser, serviceResponse) in
                if let response = findUser  {
                    self.weatherResponse = response
                    observable.onNext(response)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
}
