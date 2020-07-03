//
//  ServiceError.swift
//  Bway
//
//  Created by Thiago on 14/10/19.
//  Copyright © 2019 Bway. All rights reserved.
//

import Foundation

struct ServiceError: Codable, Error {
  
  var code: String?
  var title: String?
  var detail: String?
  var statusCode: Int?
  var error: String?
  var message: String?
}
