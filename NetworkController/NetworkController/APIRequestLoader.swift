//
//  APIRequestLoader.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//
import Foundation

class APIRequestLoader {
    let apiRequest: APIRequestConfigure
    let urlSession: Session
    
    init(apiRequest: APIRequestConfigure, urlSession: Session = URLSession.shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadRequest<T: Codable>(completionHandler: @escaping ((T?, Error?) -> Void)) {
        guard let request = try? apiRequest.makeRequest() else {
            completionHandler(nil, NetworkError.invalidRequest)
            return
        }
        urlSession.getData(with: request) { (data, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, NetworkError.noData)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(decodedData, nil)
            } catch {
                completionHandler(nil, NetworkError.invalidJSONData)
            }
        }
    }
}
