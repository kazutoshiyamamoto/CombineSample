//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var text = ""
    
    @Published var users: [User] = []
    
    private lazy var subject = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let searchUserModel: SearchUserModelProtocol
    
    init(searchUserModel: SearchUserModelProtocol) {
        self.searchUserModel = searchUserModel
        
        subject
            .sink(receiveValue: { _ in
                searchUserModel.fetchUser(query: self.text)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: {
                        print("completion: \($0)")
                    },
                    // TODO: assignに変更
                    receiveValue: {
                        self.users = $0
                        //                        print(self.users)
                    })
                    .store(in: &self.cancellables)
            })
            .store(in: &self.cancellables)
    }
    
    // TODO: 抽象的なメソッド名を修正
    func onCommit() {
        subject.send()
    }
}
