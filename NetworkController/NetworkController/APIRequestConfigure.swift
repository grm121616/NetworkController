//
//  APIRequestConfigure.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

protocol APIRequestConfigure {
    var url: String { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
    var timeoutInterval: TimeInterval? { get }
    var header: [String:String]? { get }
    var httpBody: Data? { get }
    var httpMethod: String? { get }
}

extension APIRequestConfigure {
    func makeRequest() throws -> URLRequest {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        var request = URLRequest(url: url, cachePolicy: cachePolicy ?? URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: timeoutInterval ?? 10)
        request.allHTTPHeaderFields = header
        request.httpBody = httpBody
        request.httpMethod = httpMethod
        return request
    }
}
