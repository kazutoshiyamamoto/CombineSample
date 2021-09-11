//
//  SearchUserModel.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import Foundation
import Combine

protocol SearchUserModelProtocol {
    func fetchUser(query: String) -> Future<[User], Error>
}

final class SearchUserModel: SearchUserModelProtocol {
    let session = Session()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUser(query: String) -> Future<[User], Error> {
        return Future() { promise in
            let request = SearchUsersRequest(query: query)
            self.session.send(request)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                },
                receiveValue: { response in
                    promise(.success(response.items))
                })
                .store(in: &self.cancellables)
        }
    }
}
