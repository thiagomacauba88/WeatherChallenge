//
//  WeatherRouter.swift
//  WeatherChallenge
//
//  Created by Thiago on 03/07/20.
//  Copyright © 2020 WeatherChallenge. All rights reserved.
//

import UIKit

enum WeatherRouterEvent {
    
    case itemTapped
}

class WeatherRouter {
    
    // MARK: - Segue
    enum WeatherSegue {
        case weatherDetail
        
    }
    
    //MARK: - Properties
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - Actions
    func react(to event: WeatherRouterEvent, from source: UIViewController, info: Any?) {
        switch event {
            case .itemTapped:
                self.showWeatherDetail(from: source, info: info)
        }
    }
    
    private func showWeatherDetail(from source: UIViewController, info: Any?) {
        let weatherDetailViewController = WeatherDetailViewController.instantiate(fromStoryboard: storyboard)
        weatherDetailViewController.weatherResponse = info as? WeatherResponse
        perform(.weatherDetail, from: source, to: weatherDetailViewController)
    }
}

// MARK: - Navigation
private extension WeatherRouter {
    
    func perform(_ segue: WeatherSegue, from source: UIViewController, to controller: UIViewController) {
        source.navigationController?.pushViewController(controller, animated: true)
    }
}
