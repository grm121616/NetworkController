//
//  URLSession+Session.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/6/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

protocol Session {
    func getData(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    func getData(with request: URLRequest, completionHandler: @escaping(Data?, Error?) -> Void)
}

extension URLSession: Session {
    func getData(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        self.dataTask(with: request) { (data, _, error) in
            completionHandler(data, error)
        }.resume()
    }
    
    func getData(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        self.dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }.resume()
    }
}
