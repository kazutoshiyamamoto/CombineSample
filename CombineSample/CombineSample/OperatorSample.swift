//
//  OperatorSample.swift
//  CombineSample
//
//  Created by home on 2021/08/03.
//

import SwiftUI
import Combine

struct OperatorSampleView: View {
    @ObservedObject private var viewModel: OperatorSampleViewModel
    
    init(viewModel: OperatorSampleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            TextField("文字を入力", text: $viewModel.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .padding()
            
            Text("抽出条件に合致した文字列を出力\n\(viewModel.filteredText)")
                .padding()
            
            Button("サンプルをリセット") {
                viewModel.text = ""
                viewModel.filteredText = ""
            }
        }
    }
}

struct OperatorSampleView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorSampleView(viewModel: OperatorSampleViewModel())
    }
}

final class OperatorSampleViewModel: ObservableObject {
    @Published var text = ""
    @Published var filteredText = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $text
            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
            .filter( { $0.isAlphanumeric() } )
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // ユーザーの入力が停止するのを待つ
            .receive(on: RunLoop.main)
            .assign(to: \.filteredText, on: self)
            .store(in: &cancellables)
    }
}

extension String {
    // 半角数字の判定
    func isAlphanumeric() -> Bool {
        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
    }
}
