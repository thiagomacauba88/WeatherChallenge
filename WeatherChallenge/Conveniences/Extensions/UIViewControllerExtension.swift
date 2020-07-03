//
//  UIViewControllerExtension.swift
//  Top Bank
//
//  Created by Thiago on 13/12/19.
//  Copyright © 2019 Valecard. All rights reserved.
//

import UIKit
import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Lifecycle
    override open func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.configureCustomBackButton()
    }
    
    // MARK: - MISC
    func configureCustomBackButton() {
        if let backButtonItem = navigationItem.backBarButtonItem, let leftBarButtonItem = navigationItem.leftBarButtonItem {
            backButtonItem.title = " "
            leftBarButtonItem.title = " "
        }
    }
    
    func setStatusBar() {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.colorBlueDefault
             UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        } else {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.colorBlueDefault
        }
    }
    
    public func showAlertError(for error: Error) {
        guard let serviceError = error as? ServiceError, let alertText = serviceError.message else { return }
        let bottomAlertController = BottomAlertViewController.instantiateNew(withText: alertText)
        bottomAlertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let transition = CATransition()
        transition.duration = 0.5
        transition.subtype = CATransitionSubtype.fromBottom
        if(self.view.window == nil){
             print ("We cant instanciate a window")
        } else {
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(bottomAlertController, animated: false, completion:  nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let transition = CATransition()
            transition.duration = 0.5
            transition.subtype = CATransitionSubtype.fromTop
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.dismiss(animated: false)
            }
        }
    }
}
