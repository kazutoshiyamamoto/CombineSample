//
//  Request.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var method: HttpMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
}

extension Request {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var headerFields: [String: String] {
        return ["Accept": "application/json"]
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
