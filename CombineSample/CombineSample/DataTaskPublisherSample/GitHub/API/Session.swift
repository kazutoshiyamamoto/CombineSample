//
//  Session.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import Foundation
import Combine

final class Session {
    private let additionalHeaderFields: () -> [String: String]?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(additionalHeaderFields: @escaping () -> [String: String]? = { nil }) {
        self.additionalHeaderFields = additionalHeaderFields
    }
    
    func send<T: Request>(_ request: T) -> Future<T.Response, SessionError> {
        return Future() { promise in
            let url = request.baseURL.appendingPathComponent(request.path)
            
            guard var componets = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                promise(.failure(SessionError.failedToCreateComponents(url)))
                return
            }
            componets.queryItems = request.queryParameters?.compactMap(URLQueryItem.init)
            
            guard var urlRequest = componets.url.map({ URLRequest(url: $0) }) else {
                promise(.failure(SessionError.failedToCreateURL(componets)))
                return
            }
            urlRequest.httpMethod = request.method.rawValue
            
            let headerFields: [String: String]
            if let additionalHeaderFields = self.additionalHeaderFields() {
                headerFields = request.headerFields.merging(additionalHeaderFields, uniquingKeysWith: +)
            } else {
                headerFields = request.headerFields
            }
            
            urlRequest.allHTTPHeaderFields = headerFields
            
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap() { element -> Data in
                    guard let response = element.response as? HTTPURLResponse else {
                        throw SessionError.noResponse
                    }
                    
                    guard 200 ..< 300 ~= response.statusCode else {
                        let message = try? JSONDecoder().decode(SessionError.Message.self, from: element.data)
                        throw SessionError.unacceptableStatusCode(response.statusCode, message)
                    }
                    
                    return element.data
                }
                .decode(type: T.Response.self, decoder: JSONDecoder())
                .mapError { error -> SessionError in
                    if let error = error as? DecodingError {
                        return SessionError.parserError(error.localizedDescription)
                    } else {
                        // オフラインなどのエラー
                        return SessionError.other(error.localizedDescription)
                    }
                }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                },
                receiveValue: {
                    promise(.success($0))
                })
                .store(in: &self.cancellables)
        }
    }
}

enum SessionError: Error {
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
    case noResponse
    case unacceptableStatusCode(Int, Message?)
    case parserError(String)
    case other(String)
}

extension SessionError {
    struct Message: Decodable {
        let documentationURL: URL
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case documentationURL = "documentation_url"
            case message
        }
    }
}
