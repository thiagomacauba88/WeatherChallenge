//
//  UIApplicationExtension.swift
//  Top Bank
//
//  Created by Thiago on 13/12/19.
//  Copyright © 2019 Valecard. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
