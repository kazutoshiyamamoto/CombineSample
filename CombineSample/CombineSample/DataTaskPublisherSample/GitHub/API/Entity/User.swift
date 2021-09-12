//
//  User.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import Foundation

struct User: Codable, Identifiable {
    let id = UUID()
    let login: String
    let avatarURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    init(login: String, avatarURL: URL) {
        self.login = login
        self.avatarURL = avatarURL
    }
}
