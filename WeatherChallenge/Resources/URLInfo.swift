//
//  URLInfo.swift
//  Bway
//
//  Created by Thiago on 07/10/19.
//  Copyright © 2019 Bway. All rights reserved.
//

import UIKit

import UIKit

public class URLInfo: NSObject {
    
    static func url(fromKey key: String) -> String {
        guard
            let path = Bundle.main.path(forResource: "URLs", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String]
            else {
                return ""
        }
        
        if let url = dict[key] {
            return (url)
        } else {
            return ""
        }
        
    }
}
