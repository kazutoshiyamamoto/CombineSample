//
//  SearchUserView.swift
//  CombineSample
//
//  Created by home on 2021/09/12.
//

import SwiftUI

struct SearchUserView: View {
    @ObservedObject private var viewModel: SearchUserViewModel
    
    init(viewModel: SearchUserViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $viewModel.searchText, onCommit: { viewModel.searchButtonTapped() })
                .padding([.leading, .trailing], 25)
            
            List {
                ForEach(viewModel.users) { user in
                    UserListRowView(user: user)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .alert(isPresented: $viewModel.isErrorMessageActive, content: {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
        })
    }
}

struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView(viewModel: SearchUserViewModel(searchUserModel: SearchUserModel()))
    }
}
