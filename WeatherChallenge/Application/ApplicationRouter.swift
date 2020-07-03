//
//  ApplicationRouter.swift
//  ValeCard
//
//  Created by TechMaxi on 27/09/18.
//  Copyright © 2019 ValeCard. All rights reserved.

import UIKit

class ApplicationRouter {

    // MARK: - Enum
    enum ApplicationStartPoint {
        case inital
    }
    
    // MARK: - Properties
    fileprivate lazy var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var viewController = UIViewController()
    
    // MARK: - Lifecycle
    func startApplication(in window: UIWindow?) {
        guard let window = window else { return }
        self.startApplication(in: window, startPoint: .inital)
    }

    func startApplication(in window: UIWindow, startPoint: ApplicationStartPoint) {
        switch startPoint {
        case .inital:
            let weatherViewController = WeatherViewController.instantiate(fromStoryboard: storyboard)
            let rootNavigationController = UINavigationController(rootViewController: weatherViewController)
            setRootNavigationController(rootNavigationController, for: window)
            
        }
    }
    
    fileprivate func setRootNavigationController(_ rootNavigationController: UINavigationController, for window: UIWindow) {
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        rootNavigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        rootNavigationController.setNavigationBarHidden(true, animated: false)
    }
}
