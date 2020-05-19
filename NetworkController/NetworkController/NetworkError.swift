//
//  NetworkError.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unknown
    case noData
    case invalidJSONData
    case invalidRequest
}
