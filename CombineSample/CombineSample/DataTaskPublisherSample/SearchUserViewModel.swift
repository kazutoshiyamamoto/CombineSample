//
//  SearchUserViewModel.swift
//  CombineSample
//
//  Created by home on 2021/09/12.
//

import Foundation
import Combine

final class SearchUserViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var users: [User] = []
    
    @Published var isErrorMessageActive = false
    
    var errorMessage = ""
    
    private lazy var subject = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let searchUserModel: SearchUserModelProtocol
    
    init(searchUserModel: SearchUserModelProtocol) {
        self.searchUserModel = searchUserModel
        
        subject
            .sink(receiveValue: { _ in
                searchUserModel.fetchUser(query: self.searchText)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.errorMessage = error.localizedDescription
                            self.isErrorMessageActive = true
                        }
                    },
                    receiveValue: {
                        self.users = $0
                    })
                    .store(in: &self.cancellables)
            })
            .store(in: &self.cancellables)
    }
    
    func searchButtonTapped() {
        subject.send()
    }
}
