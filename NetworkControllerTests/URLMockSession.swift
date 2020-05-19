//
//  URLMockSession.swift
//  ItuneRssNikeCodeAssignTests
//
//  Created by Ruoming Gao on 5/5/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation
@testable import NetworkController

final class URLMockSession: Session {
    
    let error: Error?
    let data: Data?
    private (set) var lastURL: URL?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func getData(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
    
    func getData(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}


