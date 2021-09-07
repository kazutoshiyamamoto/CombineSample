//
//  RepositoriesListView.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import SwiftUI

struct RepositoriesListRowView: View {
    let user: User
    
    var body: some View {
        Text(user.login)
    }
}

struct RepositoriesListRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesListRowView(user: User(login: "", avatarURL: URL(string: "")!))
    }
}
