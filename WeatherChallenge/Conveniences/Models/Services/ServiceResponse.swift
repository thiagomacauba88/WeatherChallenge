//
//  ServiceResponse.swift
//  Bway
//
//  Created by Thiago on 14/10/19.
//  Copyright © 2019 Bway. All rights reserved.
//

import Foundation

struct ServiceResponse {
    
    var data: Data?
    var rawResponse: String?
    var response: HTTPURLResponse?
    var request: URLRequest?
    var serviceError: ServiceError?
}
