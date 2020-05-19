//
//  NetworkRequestConfigure.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

struct NetworkRequestConfigure: APIRequestConfigure {
    var url: String
    
    var cachePolicy: URLRequest.CachePolicy?
    
    var timeoutInterval: TimeInterval?
    
    var header: [String : String]?
    
    var httpBody: Data?
    
    var httpMethod: String?
}
