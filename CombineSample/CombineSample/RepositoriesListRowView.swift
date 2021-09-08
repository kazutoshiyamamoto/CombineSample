//
//  RepositoriesListView.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import SwiftUI

struct RepositoriesListRowView: View {
    let user: User
    
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        HStack(spacing: 25) {
            ImageView(url: user.avatarURL, cache: cache)
            
            Text(user.login)
        }
        .frame(height: 50)
    }
}

struct RepositoriesListRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesListRowView(user: User(login: "", avatarURL: URL(string: "")!))
    }
}
